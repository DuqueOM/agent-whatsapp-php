#!/bin/sh
# Runs once, on the first start of an empty data volume.
# Creates the database used by the integration tests.
set -eu

MYSQL_PWD="$MYSQL_ROOT_PASSWORD" mysql -uroot <<SQL
CREATE DATABASE IF NOT EXISTS \`${MYSQL_TEST_DATABASE}\`
  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
GRANT ALL PRIVILEGES ON \`${MYSQL_TEST_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
SQL
