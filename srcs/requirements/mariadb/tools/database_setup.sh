#!/bin/sh

# Create SQL script
cat << EOF > /scripts/init.sql
CREATE USER IF NOT EXISTS 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
SET PASSWORD FOR 'root'@'%' = PASSWORD('${MARIADB_ROOT_PASSWORD}');
GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION;
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_USER_PASSWORD}';
SET PASSWORD FOR '${MARIADB_USER}'@'localhost' = PASSWORD('${MARIADB_USER_PASSWORD}');
GRANT ALL ON ${DATABASE_NAME}.* TO '${MARIADB_USER}'@'localhost';
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}';
SET PASSWORD FOR '${MARIADB_USER}'@'%' = PASSWORD('${MARIADB_USER_PASSWORD}');
CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};
GRANT ALL ON ${DATABASE_NAME}.* TO '${MARIADB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

#chmod 777 /scripts/init.sql
# Execute MariaDB
# https://mariadb.com/kb/en/mysqld_safe/
mysqld_safe --defaults-file="/etc/mysql/my.cnf" --user=mysql --datadir="/var/lib/mysql" --init-file="/scripts/init.sql"