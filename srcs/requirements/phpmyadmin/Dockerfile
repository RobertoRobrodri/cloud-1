# Set base image
FROM alpine:3.17

RUN echo 'https://dl-cdn.alpinelinux.org/alpine/v3.16/community' >> /etc/apk/repositories
RUN echo 'https://dl-cdn.alpinelinux.org/alpine/v3.16/main' >> /etc/apk/repositories
# Install required packages
RUN apk update && apk add --no-cache \
    php8 \
    php8-fpm \
    php8-mysqli \
    php8-json \
    php8-session \
    php8-mbstring \
    php8-gettext \
    php8-xml \
    php8-iconv \
    php8-gd \
    php8-curl \
    php8-zip \
    php8-openssl \
    php8-phar \
    apache2 \
    apache2-ssl \
    php8-apache2

# Install phpMyAdmin

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.tar.gz \
    && tar -xzvf phpMyAdmin-5.2.1-all-languages.tar.gz -C /var/www/ \
    && mv /var/www/phpMyAdmin-*-all-languages /var/www/phpmyadmin \
    && rm phpMyAdmin-5.2.1-all-languages.tar.gz

# Copy custom start script

COPY start.sh /start.sh
COPY phpmyadmin.conf /etc/apache2/conf.d/phpmyadmin.conf
COPY config.inc.php /var/www/phpmyadmin/config.inc.php
# Expose port 80
EXPOSE 80

# Start the services
CMD ["/bin/sh", "/start.sh"]
