FROM php:fpm-alpine

RUN set -ex  && apk --no-cache add postgresql-dev libmcrypt-dev imagemagick libmemcached-dev git cyrus-sasl-dev imap-dev

RUN docker-php-ext-install pdo pdo_pgsql pgsql pdo_mysql mysqli iconv mcrypt imap

RUN rm -rf /usr/src/php/ext/memcached \
  && git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
  && cd /usr/src/php/ext/memcached && git checkout -b php7 origin/php7 \
  && docker-php-ext-configure memcached \
  && docker-php-ext-install memcached


## allow ports
EXPOSE 9000

