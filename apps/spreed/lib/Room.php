<?php

declare(strict_types=1);
/**
 * @copyright Copyright (c) 2016 Lukas Reschke <lukas@statuscode.ch>
 * @copyright Copyright (c) 2016 Joas Schilling <coding@schilljs.com>
 *
 * @author Lukas Reschke <lukas@statuscode.ch>
 * @author Joas Schilling <coding@schilljs.com>
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

namespace OCA\Talk;

use OCA\Talk\Events\AAttendeeRemovedEvent;
use OCA\Talk\Events\BeforeSignalingRoomPropertiesSentEvent;
use OCA\Talk\Events\SignalingRoomPropertiesEvent;
use OCA\Talk\Exceptions\ParticipantNotFoundException;
use OCA\Talk\Model\Attendee;
use OCA\Talk\Model\SelectHelper;
use OCA\Talk\Model\Session;
use OCA\Talk\Service\ParticipantService;
use OCA\Talk\Service\RecordingService;
use OCA\Talk\Service\RoomService;
use OCP\AppFramework\Utility\ITimeFactory;
use OCP\Comments\IComment;
use OCP\EventDispatcher\IEventDispatcher;
use OCP\IDBConnection;
use OCP\Server;

class Room {
	/**
	 * Regex that matches SIP incompatible rooms:
	 * 1. duplicate digit: …11…
	 * 2. leading zero: 0…
	 * 3. non-digit: …a…
	 */
	public const SIP_INCOMPATIBLE_REGEX = '/((\d)(?=\2+)|^0|\D)/';

	public const TYPE_UNKNOWN = -1;
	public const TYPE_ONE_TO_ONE = 1;
	public const TYPE_GROUP = 2;
	public const TYPE_PUBLIC = 3;
	public const TYPE_CHANGELOG = 4;
	public const TYPE_ONE_TO_ONE_FORMER = 5;
	public const TYPE_NOTE_TO_SELF = 6;

	public const OBJECT_TYPE_EMAIL = 'emails';
	public const OBJECT_TYPE_FILE = 'file';
	public const OBJECT_TYPE_PHONE = 'phone';
	public const OBJECT_TYPE_VIDEO_VERIFICATION = 'share:password';

	public const RECORDING_NONE = 0;
	public const RECORDING_VIDEO = 1;
	public const RECORDING_AUDIO = 2;
	public const RECORDING_VIDEO_STARTING = 3;
	public const RECORDING_AUDIO_STARTING = 4;
	public const RECORDING_FAILED = 5;

	/** @deprecated Use self::TYPE_UNKNOWN */
	public const UNKNOWN_CALL = self::TYPE_UNKNOWN;
	/** @deprecated Use self::TYPE_ONE_TO_ONE */
	public const ONE_TO_ONE_CALL = self::TYPE_ONE_TO_ONE;
	/** @deprecated Use self::TYPE_GROUP */
	public const GROUP_CALL = self::TYPE_GROUP;
	/** @deprecated Use self::TYPE_PUBLIC */
	public const PUBLIC_CALL = self::TYPE_PUBLIC;
	/** @deprecated Use self::TYPE_CHANGELOG */
	public const CHANGELOG_CONVERSATION = self::TYPE_CHANGELOG;

	public const READ_WRITE = 0;
	public const READ_ONLY = 1;

	/**
	 * Only visible when joined
	 */
	public const LISTABLE_NONE = 0;

	/**
	 * Searchable by all regular users and moderators, even when not joined, excluding users created with the Guests app
	 */
	public const LISTABLE_USERS = 1;

	/**
	 * Searchable by everyone, which includes users created with the Guests app, even when not joined
	 */
	public const LISTABLE_ALL = 2;

	public const START_CALL_EVERYONE = 0;
	public const START_CALL_USERS = 1;
	public const START_CALL_MODERATORS = 2;
	public const START_CALL_NOONE = 3;

	/** @deprecated Use {@see AAttendeeRemovedEvent::REASON_REMOVED} instead */
	public const PARTICIPANT_REMOVED = 'remove';
	/** @deprecated Use {@see AAttendeeRemovedEvent::REASON_REMOVED_ALL} instead */
	public const PARTICIPANT_REMOVED_ALL = 'remove_all';
	/** @deprecated Use {@see AAttendeeRemovedEvent::REASON_LEFT} instead */
	public const PARTICIPANT_LEFT = 'leave';

	/** @deprecated */
	public const EVENT_AFTER_ROOM_CREATE = self::class . '::createdRoom';
	/** @deprecated */
	public const EVENT_BEFORE_ROOM_DELETE = self::class . '::preDeleteRoom';
	/** @deprecated */
	public const EVENT_AFTER_ROOM_DELETE = self::class . '::postDeleteRoom';
	/** @deprecated */
	public const EVENT_BEFORE_NAME_SET = self::class . '::preSetName';
	/** @deprecated */
	public const EVENT_AFTER_NAME_SET = self::class . '::postSetName';
	/** @deprecated */
	public const EVENT_BEFORE_DESCRIPTION_SET = self::class . '::preSetDescription';
	/** @deprecated */
	public const EVENT_AFTER_DESCRIPTION_SET = self::class . '::postSetDescription';
	/** @deprecated */
	public const EVENT_BEFORE_PASSWORD_SET = self::class . '::preSetPassword';
	/** @deprecated */
	public const EVENT_AFTER_PASSWORD_SET = self::class . '::postSetPassword';
	/** @deprecated */
	public const EVENT_BEFORE_TYPE_SET = self::class . '::preSetType';
	/** @deprecated */
	public const EVENT_AFTER_TYPE_SET = self::class . '::postSetType';
	/** @deprecated */
	public const EVENT_BEFORE_READONLY_SET = self::class . '::preSetReadOnly';
	/** @deprecated */
	public const EVENT_AFTER_READONLY_SET = self::class . '::postSetReadOnly';
	/** @deprecated */
	public const EVENT_BEFORE_LISTABLE_SET = self::class . '::preSetListable';
	/** @deprecated */
	public const EVENT_AFTER_LISTABLE_SET = self::class . '::postSetListable';
	/** @deprecated */
	public const EVENT_BEFORE_LOBBY_STATE_SET = self::class . '::preSetLobbyState';
	/** @deprecated */
	public const EVENT_AFTER_LOBBY_STATE_SET = self::class . '::postSetLobbyState';
	/** @deprecated */
	public const EVENT_BEFORE_END_CALL_FOR_EVERYONE = self::class . '::preEndCallForEveryone';
	/** @deprecated */
	public const EVENT_AFTER_END_CALL_FOR_EVERYONE = self::class . '::postEndCallForEveryone';
	/** @deprecated */
	public const EVENT_BEFORE_SIP_ENABLED_SET = self::class . '::preSetSIPEnabled';
	/** @deprecated */
	public const EVENT_AFTER_SIP_ENABLED_SET = self::class . '::postSetSIPEnabled';
	/** @deprecated */
	public const EVENT_BEFORE_PERMISSIONS_SET = self::class . '::preSetPermissions';
	/** @deprecated */
	public const EVENT_AFTER_PERMISSIONS_SET = self::class . '::postSetPermissions';
	/** @deprecated */
	public const EVENT_BEFORE_USERS_ADD = self::class . '::preAddUsers';
	/** @deprecated */
	public const EVENT_AFTER_USERS_ADD = self::class . '::postAddUsers';
	/** @deprecated */
	public const EVENT_BEFORE_PARTICIPANT_TYPE_SET = self::class . '::preSetParticipantType';
	/** @deprecated */
	public const EVENT_AFTER_PARTICIPANT_TYPE_SET = self::class . '::postSetParticipantType';
	/** @deprecated */
	public const EVENT_BEFORE_PARTICIPANT_PERMISSIONS_SET = self::class . '::preSetParticipantPermissions';
	/** @deprecated */
	public const EVENT_AFTER_PARTICIPANT_PERMISSIONS_SET = self::class . '::postSetParticipantPermissions';
	/** @deprecated */
	public const EVENT_BEFORE_USER_REMOVE = self::class . '::preRemoveUser';
	/** @deprecated */
	public const EVENT_AFTER_USER_REMOVE = self::class . '::postRemoveUser';
	/** @deprecated */
	public const EVENT_BEFORE_PARTICIPANT_REMOVE = self::class . '::preRemoveBySession';
	/** @deprecated */
	public const EVENT_AFTER_PARTICIPANT_REMOVE = self::class . '::postRemoveBySession';
	/** @deprecated */
	public const EVENT_BEFORE_ROOM_CONNECT = self::class . '::preJoinRoom';
	/** @deprecated */
	public const EVENT_AFTER_ROOM_CONNECT = self::class . '::postJoinRoom';
	/** @deprecated */
	public const EVENT_BEFORE_ROOM_DISCONNECT = self::class . '::preUserDisconnectRoom';
	/** @deprecated */
	public const EVENT_AFTER_ROOM_DISCONNECT = self::class . '::postUserDisconnectRoom';
	/** @deprecated  */
	public const EVENT_BEFORE_GUEST_CONNECT = self::class . '::preJoinRoomGuest';
	/** @deprecated  */
	public const EVENT_AFTER_GUEST_CONNECT = self::class . '::postJoinRoomGuest';
	/** @deprecated  */
	public const EVENT_PASSWORD_VERIFY = self::class . '::verifyPassword';
	/** @deprecated  */
	public const EVENT_BEFORE_GUESTS_CLEAN = self::class . '::preCleanGuests';
	/** @deprecated  */
	public const EVENT_AFTER_GUESTS_CLEAN = self::class . '::postCleanGuests';
	/** @deprecated */
	public const EVENT_BEFORE_SESSION_JOIN_CALL = self::class . '::preSessionJoinCall';
	/** @deprecated */
	public const EVENT_AFTER_SESSION_JOIN_CALL = self::class . '::postSessionJoinCall';
	/** @deprecated */
	public const EVENT_BEFORE_SESSION_UPDATE_CALL_FLAGS = self::class . '::preSessionUpdateCallFlags';
	/** @deprecated */
	public const EVENT_AFTER_SESSION_UPDATE_CALL_FLAGS = self::class . '::postSessionUpdateCallFlags';
	/** @deprecated */
	public const EVENT_BEFORE_SESSION_LEAVE_CALL = self::class . '::preSessionLeaveCall';
	/** @deprecated */
	public const EVENT_AFTER_SESSION_LEAVE_CALL = self::class . '::postSessionLeaveCall';
	/** @deprecated */
	public const EVENT_BEFORE_SIGNALING_PROPERTIES = self::class . '::beforeSignalingProperties';
	/** @deprecated  */
	public const EVENT_BEFORE_SET_MESSAGE_EXPIRATION = self::class . '::beforeSetMessageExpiration';
	/** @deprecated  */
	public const EVENT_AFTER_SET_MESSAGE_EXPIRATION = self::class . '::afterSetMessageExpiration';
	/** @deprecated  */
	public const EVENT_BEFORE_SET_BREAKOUT_ROOM_MODE = self::class . '::beforeSetBreakoutRoomMode';
	/** @deprecated  */
	public const EVENT_AFTER_SET_BREAKOUT_ROOM_MODE = self::class . '::afterSetBreakoutRoomMode';
	/** @deprecated  */
	public const EVENT_BEFORE_SET_BREAKOUT_ROOM_STATUS = self::class . '::beforeSetBreakoutRoomStatus';
	/** @deprecated  */
	public const EVENT_AFTER_SET_BREAKOUT_ROOM_STATUS = self::class . '::afterSetBreakoutRoomStatus';
	/** @deprecated  */
	public const EVENT_BEFORE_SET_CALL_RECORDING = self::class . '::beforeSetCallRecording';
	/** @deprecated  */
	public const EVENT_AFTER_SET_CALL_RECORDING = self::class . '::afterSetCallRecording';
	/** @deprecated  */
	public const EVENT_BEFORE_AVATAR_SET = self::class . '::preSetAvatar';
	/** @deprecated  */
	public const EVENT_AFTER_AVATAR_SET = self::class . '::postSetAvatar';

	public const DESCRIPTION_MAXIMUM_LENGTH = 500;

	protected ?string $currentUser = null;
	protected ?Participant $participant = null;

	/**
	 * @psalm-param Room::TYPE_* $type
	 * @psalm-param RecordingService::CONSENT_REQUIRED_* $recordingConsent
	 */
	public function __construct(
		private Manager $manager,
		private IDBConnection $db,
		private IEventDispatcher $dispatcher,
		private ITimeFactory $timeFactory,
		private int $id,
		private int $type,
		private int $readOnly,
		private int $listable,
		private int $messageExpiration,
		private int $lobbyState,
		private int $sipEnabled,
		private ?int $assignedSignalingServer,
		private string $token,
		private string $name,
		private string $description,
		private string $password,
		private string $avatar,
		private string $remoteServer,
		private string $remoteToken,
		private int $activeGuests,
		private int $defaultPermissions,
		private int $callPermissions,
		private int $callFlag,
		private ?\DateTime $activeSince,
		private ?\DateTime $lastActivity,
		private int $lastMessageId,
		private ?IComment $lastMessage,
		private ?\DateTime $lobbyTimer,
		private string $objectType,
		private string $objectId,
		private int $breakoutRoomMode,
		private int $breakoutRoomStatus,
		private int $callRecording,
		private int $recordingConsent,
	) {
	}

	public function getId(): int {
		return $this->id;
	}

	/**
	 * @return int
	 * @psalm-return Room::TYPE_*
	 */
	public function getType(): int {
		return $this->type;
	}

	/**
	 * @param int $type
	 * @psalm-param Room::TYPE_* $type
	 */
	public function setType(int $type): void {
		$this->type = $type;
	}

	public function getReadOnly(): int {
		return $this->readOnly;
	}

	/**
	 * @param int $readOnly Currently it is only allowed to change between
	 * 						`self::READ_ONLY` and `self::READ_WRITE`
	 * 						Also it's only allowed on rooms of type
	 * 						`self::TYPE_GROUP` and `self::TYPE_PUBLIC`
	 */
	public function setReadOnly(int $readOnly): void {
		$this->readOnly = $readOnly;
	}

	public function getListable(): int {
		return $this->listable;
	}

	/**
	 * @param int $newState New listable scope from self::LISTABLE_*
	 * 						Also it's only allowed on rooms of type
	 * 						`self::TYPE_GROUP` and `self::TYPE_PUBLIC`
	 */
	public function setListable(int $newState): void {
		$this->listable = $newState;
	}

	public function getMessageExpiration(): int {
		return $this->messageExpiration;
	}

	public function setMessageExpiration(int $messageExpiration): void {
		$this->messageExpiration = $messageExpiration;
	}

	public function getLobbyState(bool $validateTime = true): int {
		if ($validateTime) {
			$this->validateTimer();
		}
		return $this->lobbyState;
	}

	public function setLobbyState(int $lobbyState): void {
		$this->lobbyState = $lobbyState;
	}

	public function getLobbyTimer(bool $validateTime = true): ?\DateTime {
		if ($validateTime) {
			$this->validateTimer();
		}
		return $this->lobbyTimer;
	}

	public function setLobbyTimer(?\DateTime $lobbyTimer): void {
		$this->lobbyTimer = $lobbyTimer;
	}

	protected function validateTimer(): void {
		if ($this->lobbyTimer !== null && $this->lobbyTimer < $this->timeFactory->getDateTime()) {
			/** @var RoomService $roomService */
			$roomService = Server::get(RoomService::class);
			$roomService->setLobby($this, Webinary::LOBBY_NONE, null, true);
		}
	}

	public function getSIPEnabled(): int {
		return $this->sipEnabled;
	}

	public function setSIPEnabled(int $sipEnabled): void {
		$this->sipEnabled = $sipEnabled;
	}

	public function getAssignedSignalingServer(): ?int {
		return $this->assignedSignalingServer;
	}

	public function setAssignedSignalingServer(?int $assignedSignalingServer): void {
		$this->assignedSignalingServer = $assignedSignalingServer;
	}

	public function getToken(): string {
		return $this->token;
	}

	public function getName(): string {
		if ($this->type === self::TYPE_ONE_TO_ONE) {
			if ($this->name === '') {
				// TODO use DI
				$participantService = Server::get(ParticipantService::class);
				// Fill the room name with the participants for 1-to-1 conversations
				$users = $participantService->getParticipantUserIds($this);
				sort($users);
				/** @var RoomService $roomService */
				$roomService = Server::get(RoomService::class);
				$roomService->setName($this, json_encode($users), '');
			} elseif (strpos($this->name, '["') !== 0) {
				// TODO use DI
				$participantService = Server::get(ParticipantService::class);
				// Not the json array, but the old fallback when someone left
				$users = $participantService->getParticipantUserIds($this);
				if (count($users) !== 2) {
					$users[] = $this->name;
				}
				sort($users);
				/** @var RoomService $roomService */
				$roomService = Server::get(RoomService::class);
				$roomService->setName($this, json_encode($users), '');
			}
		}
		return $this->name;
	}

	public function setName(string $name): void {
		$this->name = $name;
	}

	public function getSecondParticipant(string $userId): string {
		if ($this->getType() !== self::TYPE_ONE_TO_ONE) {
			throw new \InvalidArgumentException('Not a one-to-one room');
		}
		$participants = json_decode($this->getName(), true);

		foreach ($participants as $uid) {
			if ($uid !== $userId) {
				return $uid;
			}
		}

		return $this->getName();
	}

	public function getDisplayName(string $userId, bool $forceName = false): string {
		return $this->manager->resolveRoomDisplayName($this, $userId, $forceName);
	}

	public function getDescription(): string {
		return $this->description;
	}

	public function setDescription(string $description): void {
		$this->description = $description;
	}

	/**
	 * @deprecated Use ParticipantService::getGuestCount() instead
	 * @return int
	 */
	public function getActiveGuests(): int {
		return $this->activeGuests;
	}

	public function resetActiveSince(): void {
		$this->activeGuests = 0;
		$this->activeSince = null;
	}

	public function getDefaultPermissions(): int {
		return $this->defaultPermissions;
	}

	public function setDefaultPermissions(int $defaultPermissions): void {
		$this->defaultPermissions = $defaultPermissions;
	}

	public function getCallPermissions(): int {
		return $this->callPermissions;
	}

	public function setCallPermissions(int $callPermissions): void {
		$this->callPermissions = $callPermissions;
	}

	public function getCallFlag(): int {
		return $this->callFlag;
	}

	public function getActiveSince(): ?\DateTime {
		return $this->activeSince;
	}

	public function getLastActivity(): ?\DateTime {
		return $this->lastActivity;
	}

	public function setLastActivity(\DateTime $now): void {
		$this->lastActivity = $now;
	}

	public function getLastMessage(): ?IComment {
		if ($this->lastMessageId && $this->lastMessage === null) {
			$this->lastMessage = $this->manager->loadLastCommentInfo($this->lastMessageId);
			if ($this->lastMessage === null) {
				$this->lastMessageId = 0;
			}
		}

		return $this->lastMessage;
	}

	public function setLastMessage(IComment $message): void {
		$this->lastMessage = $message;
		$this->lastMessageId = (int) $message->getId();
	}

	public function getObjectType(): string {
		return $this->objectType;
	}

	public function getObjectId(): string {
		return $this->objectId;
	}

	public function hasPassword(): bool {
		return $this->password !== '';
	}

	public function getPassword(): string {
		return $this->password;
	}

	public function setPassword(string $password): void {
		$this->password = $password;
	}

	public function setAvatar(string $avatar): void {
		$this->avatar = $avatar;
	}

	public function getAvatar(): string {
		return $this->avatar;
	}

	public function getRemoteServer(): string {
		return $this->remoteServer;
	}

	public function getRemoteToken(): string {
		return $this->remoteToken;
	}

	public function isFederatedRemoteRoom(): bool {
		return $this->remoteServer !== '';
	}

	public function setParticipant(?string $userId, Participant $participant): void {
		// FIXME Also used with cloudId, need actorType checking?
		$this->currentUser = $userId;
		$this->participant = $participant;
	}

	/**
	 * Return the room properties to send to the signaling server.
	 *
	 * @param string $userId
	 * @param bool $roomModified
	 * @return array
	 */
	public function getPropertiesForSignaling(string $userId, bool $roomModified = true): array {
		$properties = [
			'name' => $this->getDisplayName($userId),
			'type' => $this->getType(),
			'lobby-state' => $this->getLobbyState(),
			'lobby-timer' => $this->getLobbyTimer(),
			'read-only' => $this->getReadOnly(),
			'listable' => $this->getListable(),
			'active-since' => $this->getActiveSince(),
			'sip-enabled' => $this->getSIPEnabled(),
		];

		if ($roomModified) {
			$properties['description'] = $this->getDescription();
		} else {
			$properties['participant-list'] = 'refresh';
		}

		$event = new SignalingRoomPropertiesEvent($this, $userId, $properties);
		$this->dispatcher->dispatch(self::EVENT_BEFORE_SIGNALING_PROPERTIES, $event);
		$event = new BeforeSignalingRoomPropertiesSentEvent($this, $userId, $event->getProperties());
		$this->dispatcher->dispatchTyped($event);
		return $event->getProperties();
	}

	/**
	 * @param string|null $userId
	 * @param string|null|false $sessionId Set to false if you don't want to load a session (and save resources),
	 *                                     string to try loading a specific session
	 *                                     null to try loading "any"
	 * @return Participant
	 * @throws ParticipantNotFoundException When the user is not a participant
	 * @deprecated
	 */
	public function getParticipant(?string $userId, $sessionId = null): Participant {
		if (!is_string($userId) || $userId === '') {
			throw new ParticipantNotFoundException('Not a user');
		}

		if ($this->currentUser === $userId && $this->participant instanceof Participant) {
			if (!$sessionId
				|| ($this->participant->getSession() instanceof Session
					&& $this->participant->getSession()->getSessionId() === $sessionId)) {
				return $this->participant;
			}
		}

		$query = $this->db->getQueryBuilder();
		$helper = new SelectHelper();
		$helper->selectAttendeesTable($query);
		$query->from('talk_attendees', 'a')
			->where($query->expr()->eq('a.actor_type', $query->createNamedParameter(Attendee::ACTOR_USERS)))
			->andWhere($query->expr()->eq('a.actor_id', $query->createNamedParameter($userId)))
			->andWhere($query->expr()->eq('a.room_id', $query->createNamedParameter($this->getId())))
			->setMaxResults(1);

		if ($sessionId !== false) {
			if ($sessionId !== null) {
				$helper->selectSessionsTable($query);
				$query->leftJoin('a', 'talk_sessions', 's', $query->expr()->andX(
					$query->expr()->eq('s.session_id', $query->createNamedParameter($sessionId)),
					$query->expr()->eq('a.id', 's.attendee_id')
				));
			} else {
				$helper->selectSessionsTable($query); // FIXME PROBLEM
				$query->leftJoin('a', 'talk_sessions', 's', $query->expr()->eq('a.id', 's.attendee_id'));
			}
		}

		$result = $query->executeQuery();
		$row = $result->fetch();
		$result->closeCursor();

		if ($row === false) {
			throw new ParticipantNotFoundException('User is not a participant');
		}

		if ($this->currentUser === $userId) {
			$this->participant = $this->manager->createParticipantObject($this, $row);
			return $this->participant;
		}

		return $this->manager->createParticipantObject($this, $row);
	}

	public function setActiveSince(\DateTime $since, int $callFlag, bool $isGuest): void {
		if (!$this->activeSince) {
			$this->activeSince = $since;
		}
		$this->callFlag |= $callFlag;
		if ($isGuest) {
			$this->activeGuests++;
		}
	}

	public function getBreakoutRoomMode(): int {
		return $this->breakoutRoomMode;
	}

	public function setBreakoutRoomMode(int $mode): void {
		$this->breakoutRoomMode = $mode;
	}

	public function getBreakoutRoomStatus(): int {
		return $this->breakoutRoomStatus;
	}

	public function setBreakoutRoomStatus(int $status): void {
		$this->breakoutRoomStatus = $status;
	}

	public function getCallRecording(): int {
		return $this->callRecording;
	}

	public function setCallRecording(int $callRecording): void {
		$this->callRecording = $callRecording;
	}

	/**
	 * @return RecordingService::CONSENT_REQUIRED_*
	 */
	public function getRecordingConsent(): int {
		return $this->recordingConsent;
	}

	/**
	 * @param int $recordingConsent
	 * @psalm-param RecordingService::CONSENT_REQUIRED_* $recordingConsent
	 */
	public function setRecordingConsent(int $recordingConsent): void {
		$this->recordingConsent = $recordingConsent;
	}
}
