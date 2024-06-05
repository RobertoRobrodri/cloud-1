# Set base image
FROM alpine:3.17

# Set working directory
WORKDIR /var/www/html

# Add links to packages of the previous version
RUN echo 'https://dl-cdn.alpinelinux.org/alpine/v3.16/community' >> /etc/apk/repositories
RUN echo 'https://dl-cdn.alpinelinux.org/alpine/v3.16/main' >> /etc/apk/repositories

# Install packages
RUN apk update && apk add php8 php8-fpm php8-phar php8-curl mariadb-client php8-mysqli php8-iconv

# Download and extract WordPress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && wp core download --allow-root

# Copy php-fpm configuration
COPY www.conf /etc/php8/php-fpm.d/www.conf
RUN rm -rf wp-config.php

# Expose port
EXPOSE 9000
COPY start.sh /start.sh

# Start the script
CMD ["/bin/sh", "/start.sh"]