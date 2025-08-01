<?php
/**
 * @author Joas Schilling <coding@schilljs.com>
 *
 * @copyright Copyright (c) 2016, ownCloud, Inc.
 * @license AGPL-3.0
 *
 * This code is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License, version 3,
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License, version 3,
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 *
 */

namespace OCA\Survey_Client\Categories;

use OCP\IConfig;
use OCP\IDBConnection;
use OCP\IL10N;

/**
 * Class Database
 *
 * @package OCA\Survey_Client\Categories
 */
class Database implements ICategory {
	/** @var IConfig */
	protected $config;

	/** @var IDBConnection */
	protected $connection;

	/** @var IL10N */
	protected $l;

	public function __construct(IConfig $config, IDBConnection $connection, IL10N $l) {
		$this->config = $config;
		$this->connection = $connection;
		$this->l = $l;
	}

	/**
	 * @return string
	 */
	public function getCategory() {
		return 'database';
	}

	/**
	 * @return string
	 */
	public function getDisplayName() {
		return $this->l->t('Database environment <em>(type, version, database size)</em>');
	}

	/**
	 * @return array (string => string|int)
	 */
	public function getData() {
		return [
			'type' => $this->config->getSystemValue('dbtype'),
			'version' => $this->databaseVersion(),
			'size' => $this->databaseSize(),
		];
	}

	protected function databaseVersion() {
		switch ($this->config->getSystemValue('dbtype')) {
			case 'sqlite':
			case 'sqlite3':
				$sql = 'SELECT sqlite_version() AS version';
				break;

			case 'oci':
				$sql = 'SELECT version FROM v$instance';
				break;

			case 'mysql':
			case 'pgsql':
			default:
				$sql = 'SELECT VERSION() AS version';
				break;
		}

		$result = $this->connection->executeQuery($sql);
		$row = $result->fetch();
		$result->closeCursor();

		if ($row) {
			return $this->cleanVersion($row['version']);
		}

		return 'N/A';
	}

	/**
	 * Copy of phpBB's get_database_size()
	 * @link https://github.com/phpbb/phpbb/blob/release-3.1.6/phpBB/includes/functions_admin.php#L2908-L3043
	 *
	 * @copyright (c) phpBB Limited <https://www.phpbb.com>
	 * @license GNU General Public License, version 2 (GPL-2.0)
	 *
	 * @return int|string
	 */
	protected function databaseSize() {
		$database_size = false;

		// This code is heavily influenced by a similar routine in phpMyAdmin 2.2.0
		switch ($this->config->getSystemValue('dbtype')) {
			case 'mysql':
				$db_name = $this->config->getSystemValue('dbname');
				$sql = 'SHOW TABLE STATUS FROM `' . $db_name . '`';
				$result = $this->connection->executeQuery($sql);
				$database_size = 0;
				while ($row = $result->fetch()) {
					if ((isset($row['Type']) && $row['Type'] !== 'MRG_MyISAM') || (isset($row['Engine']) && ($row['Engine'] === 'MyISAM' || $row['Engine'] === 'InnoDB'))) {
						$database_size += $row['Data_length'] + $row['Index_length'];
					}
				}
				$result->closeCursor();
				break;

			case 'sqlite':
			case 'sqlite3':
				if (file_exists($this->config->getSystemValue('dbhost'))) {
					$database_size = filesize($this->config->getSystemValue('dbhost'));
				} else {
					/** @psalm-suppress UndefinedInterfaceMethod */
					$params = $this->connection->getInner()->getParams();
					if (file_exists($params['path'])) {
						$database_size = filesize($params['path']);
					}
				}
				break;

			case 'pgsql':
				$sql = "SELECT proname
					FROM pg_proc
					WHERE proname = 'pg_database_size'";
				$result = $this->connection->executeQuery($sql);
				$row = $result->fetch();
				$result->closeCursor();
				if ($row['proname'] === 'pg_database_size') {
					$database = $this->config->getSystemValue('dbname');
					if (strpos($database, '.') !== false) {
						[$database, ] = explode('.', $database);
					}
					$sql = "SELECT oid
						FROM pg_database
						WHERE datname = '$database'";
					$result = $this->connection->executeQuery($sql);
					$row = $result->fetch();
					$result->closeCursor();
					$oid = $row['oid'];
					$sql = 'SELECT pg_database_size(' . $oid . ') as size';
					$result = $this->connection->executeQuery($sql);
					$row = $result->fetch();
					$result->closeCursor();
					$database_size = $row['size'];
				}
				break;

			case 'oci':
				$sql = 'SELECT SUM(bytes) as dbsize
					FROM user_segments';
				$result = $this->connection->executeQuery($sql);
				$database_size = ($row = $result->fetch()) ? $row['dbsize'] : false;
				$result->closeCursor();
				break;
		}

		return ($database_size !== false) ? $database_size : 'N/A';
	}

	/**
	 * Try to strip away additional information
	 *
	 * @param string $version E.g. `5.6.27-0ubuntu0.14.04.1`
	 * @return string `5.6.27`
	 */
	protected function cleanVersion($version) {
		$matches = [];
		preg_match('/^(\d+)(\.\d+)(\.\d+)/', $version, $matches);
		if (isset($matches[0])) {
			return $matches[0];
		}

		return $version;
	}
}
