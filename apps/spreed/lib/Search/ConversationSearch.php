<?php

declare(strict_types=1);
/**
 * @copyright Copyright (c) 2020 Joas Schilling <coding@schilljs.com>
 *
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

namespace OCA\Talk\Search;

use OCA\Talk\AppInfo\Application;
use OCA\Talk\Config;
use OCA\Talk\Manager;
use OCA\Talk\Room;
use OCA\Talk\Service\AvatarService;
use OCP\IL10N;
use OCP\IURLGenerator;
use OCP\IUser;
use OCP\IUserSession;
use OCP\Search\IProvider;
use OCP\Search\ISearchQuery;
use OCP\Search\SearchResult;
use OCP\Search\SearchResultEntry;

class ConversationSearch implements IProvider {

	public function __construct(
		protected AvatarService $avatarService,
		protected Manager $manager,
		protected IURLGenerator $url,
		protected IL10N $l,
		protected Config $talkConfig,
		protected IUserSession $userSession,
	) {
	}

	/**
	 * @inheritDoc
	 */
	public function getId(): string {
		return 'talk-conversations';
	}

	/**
	 * @inheritDoc
	 */
	public function getName(): string {
		return $this->l->t('Conversations');
	}

	/**
	 * @inheritDoc
	 */
	public function getOrder(string $route, array $routeParameters): ?int {
		$currentUser = $this->userSession->getUser();
		if ($currentUser && $this->talkConfig->isDisabledForUser($currentUser)) {
			return null;
		}

		if (strpos($route, Application::APP_ID . '.') === 0) {
			// Active app, prefer Talk results
			return -1;
		}

		return 25;
	}

	/**
	 * Search for user's conversations
	 *
	 * Cursor is the conversation token
	 * Results are sorted by display name and then conversation token
	 *
	 * @inheritDoc
	 */
	public function search(IUser $user, ISearchQuery $query): SearchResult {
		$rooms = $this->manager->getRoomsForUser($user->getUID());

		$cursorKey = null;
		$result = [];
		foreach ($rooms as $room) {
			if ($room->getType() === Room::TYPE_CHANGELOG) {
				continue;
			}

			$parameters = $query->getRouteParameters();
			if (isset($parameters['token']) &&
				$parameters['token'] === $room->getToken() &&
				strpos($query->getRoute(), Application::APP_ID . '.') === 0) {
				// Don't search the current conversation.
				// User most likely looks for other things with the same name
				continue;
			}

			$displayName = $room->getDisplayName($user->getUID());
			if ($room->getType() === Room::TYPE_ONE_TO_ONE || $room->getType() === Room::TYPE_ONE_TO_ONE_FORMER) {
				$otherUserId = str_replace(
					json_encode($user->getUID()),
					'',
					$room->getName()
				);
				if (stripos($otherUserId, $query->getTerm()) === false
					&& stripos($displayName, $query->getTerm()) === false) {
					// Neither name nor displayname (one-to-one) match, skip
					continue;
				}
			} elseif (stripos($room->getName(), $query->getTerm()) === false) {
				continue;
			}

			$entry = new SearchResultEntry(
				$this->avatarService->getAvatarUrl($room),
				$displayName,
				'',
				$this->url->linkToRouteAbsolute('spreed.Page.showCall', ['token' => $room->getToken()]),
				'',
				true
			);

			$entry->addAttribute('conversation', $room->getToken());

			$result[strtolower($displayName . '#' . $room->getToken())] = $entry;

			if ($query->getCursor() === $room->getToken()) {
				$cursorKey = strtolower($displayName . '#' . $room->getToken());
			}
		}

		if (count($result) <= $query->getLimit()) {
			return SearchResult::complete(
				$this->l->t('Conversations'),
				array_values($result),
			);
		}
		ksort($result);

		$newCursorWithName = '#';
		if ($cursorKey) {
			$foundCursor = false;
			$filteredResults = [];
			$lastPossibleCursor = '#';
			foreach ($result as $key => $entry) {
				if ($cursorKey === $key) {
					$foundCursor = true;
					continue;
				}
				if (!$foundCursor) {
					continue;
				}

				if (count($filteredResults) === $query->getLimit()) {
					// We already have enough results, but there are more,
					// so we add the cursor for the next request.
					$newCursorWithName = $lastPossibleCursor;
					break;
				}

				$filteredResults[] = $entry;
				$lastPossibleCursor = $key;
			}
		} else {
			$filteredResults = array_slice($result, 0, $query->getLimit());
			// Next page starts at the last result
			$newCursorWithName = array_key_last($filteredResults);
		}

		// Cursor is the token only (to survive renamed),
		// but the array key is `display name#token`, so we split by the #
		// and get the last part which is the token.
		// If it's empty, there is no cursor for a next page
		$parts = explode('#', $newCursorWithName);
		$newCursor = end($parts);

		return SearchResult::paginated(
			$this->l->t('Conversations'),
			array_values($filteredResults),
			$newCursor
		);
	}
}
