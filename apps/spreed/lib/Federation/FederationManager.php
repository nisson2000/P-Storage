<?php

declare(strict_types=1);
/**
 * @copyright Copyright (c) 2021 Gary Kim <gary@garykim.dev>
 *
 * @author Gary Kim <gary@garykim.dev>
 *
 * @license GNU AGPL version 3 or any later version
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

namespace OCA\Talk\Federation;

use OCA\Talk\AppInfo\Application;
use OCA\Talk\Exceptions\CannotReachRemoteException;
use OCA\Talk\Exceptions\RoomNotFoundException;
use OCA\Talk\Exceptions\UnauthorizedException;
use OCA\Talk\Manager;
use OCA\Talk\Model\Attendee;
use OCA\Talk\Model\Invitation;
use OCA\Talk\Model\InvitationMapper;
use OCA\Talk\Room;
use OCA\Talk\Service\ParticipantService;
use OCP\AppFramework\Db\DoesNotExistException;
use OCP\IConfig;
use OCP\IUser;
use OCP\Notification\IManager;
use SensitiveParameter;

/**
 * Class FederationManager
 *
 * @package OCA\Talk\Federation
 *
 * FederationManager handles incoming federated rooms
 */
class FederationManager {
	public const TALK_ROOM_RESOURCE = 'talk-room';
	public const TALK_PROTOCOL_NAME = 'nctalk';
	public const NOTIFICATION_SHARE_ACCEPTED = 'SHARE_ACCEPTED';
	public const NOTIFICATION_SHARE_DECLINED = 'SHARE_DECLINED';
	public const NOTIFICATION_SHARE_UNSHARED = 'SHARE_UNSHARED';
	public const NOTIFICATION_ROOM_MODIFIED = 'ROOM_MODIFIED';
	public const TOKEN_LENGTH = 64;

	public function __construct(
		private IConfig $config,
		private Manager $manager,
		private ParticipantService $participantService,
		private InvitationMapper $invitationMapper,
		private BackendNotifier $backendNotifier,
		private IManager $notificationManager,
	) {
	}

	/**
	 * Determine if Talk federation is enabled on this instance
	 * @return bool
	 * @deprecated use \OCA\Talk\Config::isFederationEnabled()
	 */
	public function isEnabled(): bool {
		// TODO: Set to default true once implementation is complete
		return $this->config->getAppValue(Application::APP_ID, 'federation_enabled', 'no') === 'yes';
	}

	public function addRemoteRoom(
		IUser $user,
		int $remoteAttendeeId,
		int $roomType,
		string $roomName,
		string $remoteToken,
		string $remoteServerUrl,
		#[SensitiveParameter]
		string $sharedSecret,
	): Invitation {
		try {
			$room = $this->manager->getRoomByToken($remoteToken, null, $remoteServerUrl);
		} catch (RoomNotFoundException) {
			$room = $this->manager->createRemoteRoom($roomType, $roomName, $remoteToken, $remoteServerUrl);
		}

		$invitation = new Invitation();
		$invitation->setUserId($user->getUID());
		$invitation->setState(Invitation::STATE_PENDING);
		$invitation->setLocalRoomId($room->getId());
		$invitation->setAccessToken($sharedSecret);
		$invitation->setRemoteServerUrl($remoteServerUrl);
		$invitation->setRemoteToken($remoteToken);
		$invitation->setRemoteAttendeeId($remoteAttendeeId);
		$this->invitationMapper->insert($invitation);

		return $invitation;
	}

	protected function markNotificationProcessed(string $userId, int $shareId): void {
		$notification = $this->notificationManager->createNotification();
		$notification->setApp(Application::APP_ID)
			->setUser($userId)
			->setObject('remote_talk_share', (string) $shareId);
		$this->notificationManager->markProcessed($notification);
	}

	/**
	 * @throws UnauthorizedException
	 * @throws DoesNotExistException
	 * @throws CannotReachRemoteException
	 */
	public function acceptRemoteRoomShare(IUser $user, int $shareId): void {
		$invitation = $this->invitationMapper->getInvitationById($shareId);
		if ($invitation->getUserId() !== $user->getUID()) {
			throw new UnauthorizedException('invitation is for a different user');
		}

		// Add user to the room
		$room = $this->manager->getRoomById($invitation->getLocalRoomId());
		if (
			!$this->backendNotifier->sendShareAccepted($invitation->getRemoteServerUrl(), $invitation->getRemoteAttendeeId(), $invitation->getAccessToken())
		) {
			throw new CannotReachRemoteException();
		}

		$participant = [
			[
				'actorType' => Attendee::ACTOR_USERS,
				'actorId' => $user->getUID(),
				'displayName' => $user->getDisplayName(),
				'accessToken' => $invitation->getAccessToken(),
				'remoteId' => $invitation->getRemoteAttendeeId(), // FIXME this seems unnecessary
			]
		];
		$this->participantService->addUsers($room, $participant, $user);

		$invitation->setState(Invitation::STATE_ACCEPTED);
		$this->invitationMapper->update($invitation);

		$this->markNotificationProcessed($user->getUID(), $shareId);
	}

	/**
	 * @throws DoesNotExistException
	 */
	public function getRemoteShareById(int $shareId): Invitation {
		return $this->invitationMapper->getInvitationById($shareId);
	}

	/**
	 * @throws UnauthorizedException
	 * @throws DoesNotExistException
	 */
	public function rejectRemoteRoomShare(IUser $user, int $shareId): void {
		$invitation = $this->invitationMapper->getInvitationById($shareId);
		if ($invitation->getUserId() !== $user->getUID()) {
			throw new UnauthorizedException('invitation is for a different user');
		}

		$this->invitationMapper->delete($invitation);
		$this->markNotificationProcessed($user->getUID(), $shareId);

		$this->backendNotifier->sendShareDeclined($invitation->getRemoteServerUrl(), $invitation->getRemoteAttendeeId(), $invitation->getAccessToken());
	}

	/**
	 * @param IUser $user
	 * @return Invitation[]
	 */
	public function getRemoteRoomShares(IUser $user): array {
		return $this->invitationMapper->getInvitationsForUser($user);
	}

	public function getNumberOfInvitations(Room $room): int {
		return $this->invitationMapper->countInvitationsForLocalRoom($room);
	}
}
