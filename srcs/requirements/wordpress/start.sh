#!/bin/sh

# If wp-config.php doesn't exist, configure and install WordPress
sleep 5
if [ ! -f /var/www/html/wp-config.php ]; then
    wp config create --dbname=$DATABASENAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$DB_HOST --allow-root
fi
wp core install --url=$DOMAIN_NAME --title=$PROJECT --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$LOGIN@inception.com --allow-root

# Start php-fpm
exec php-fpm8 -F
