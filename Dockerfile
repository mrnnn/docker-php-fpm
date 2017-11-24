FROM php:7.1-fpm-alpine
MAINTAINER Marijn Vandevoorde <marijnnn@gmail.com>

# Install GD extension
RUN apk add --no-cache \
      freetype-dev libpng-dev libjpeg-turbo-dev \
      curl-dev icu-dev gettext-dev libmcrypt-dev libxml2-dev\
      freetype libpng libjpeg libmcrypt gettext libintl icu \
    && docker-php-ext-configure gd \
      --with-freetype-dir=/usr/include/ \
      --with-png-dir=/usr/include/ \
      --with-jpeg-dir=/usr/include/ \
    && NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j${NPROC} gd curl bcmath ctype \
    exif gettext iconv intl json mbstring mcrypt opcache xml mysqli dom \
    pdo pdo_mysql session sockets zip  \
    && apk del freetype-dev libpng-dev libjpeg-turbo-dev \
      curl-dev icu-dev gettext-dev libxml2-dev libmcrypt-dev

RUN rm -rf /var/cache/apk/*

WORKDIR /code
