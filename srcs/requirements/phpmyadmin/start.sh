#!/bin/sh

# Ensure that PHP-FPM is started
php-fpm8

# Start Apache in foreground
httpd -D FOREGROUND
