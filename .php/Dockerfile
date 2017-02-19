FROM php:fpm-alpine

RUN set -ex  && apk --no-cache add postgresql-dev libmcrypt-dev
RUN docker-php-ext-install pdo pdo_pgsql pgsql pdo_mysql mysqli iconv mcrypt


## allow ports
EXPOSE 9000

