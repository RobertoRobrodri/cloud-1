# Set base image
FROM alpine:3.17

# Update apk and install mariadb package
RUN apk update && apk add mariadb

# Create directory for SQL Scripts
RUN mkdir /scripts

# Copy database setup script and maraiadb config
COPY tools/database_setup.sh /scripts
COPY ./conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf

# Init database
# https://mariadb.com/kb/en/mariadb-install-db/
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Expose port for MariaDB
EXPOSE 3306

# Execute script that creates init.sql and execute mariadb
CMD ["/bin/sh", "/scripts/database_setup.sh"]
