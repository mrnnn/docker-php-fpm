FROM alpine:3.6

# Environments
ENV TIMEZONE            Europe/Brussels
ENV PHP_MEMORY_LIMIT    256M
ENV MAX_UPLOAD          50M
ENV PHP_MAX_FILE_UPLOAD 100
ENV PHP_MAX_POST        100M

ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
RUN echo "http://php.codecasts.rocks/v3.6/php-7.1" >> /etc/apk/repositories && \
    apk add --update php7-fpm php7-bcmath php7-ctype php7-curl php7-exif php7-gd php7-gettext\
    php7-iconv php7-intl php7-json php7-mbstring php7-mcrypt php7-opcache\
     php7-pdo php7-pdo_mysql php7-pdo_sqlite php7-session php7-sockets php7-zip php7-imagick
#  php7-openssl for certificate en/de-crypting
#  php7-pcntl  process control stuff
#  php7-pear php7-phar for making packages
#  php7-xml php7-xmlreader for xml stuff
#  php7-redis php7-memcached redis & memcached
#  php7-zlib gzip


RUN sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php7/php-fpm.conf && \
    	sed -i "s|;*listen\s*=\s*127.0.0.1:9000|;listen = 9000|g" /etc/php7/php-fpm.d/www.conf && \
    	sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php7/php.ini && \
    	sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini && \
        sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php7/php.ini && \
        sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini && \
        sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini && \
        sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php7/php.ini

RUN sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php7/php.ini

RUN rm -rf /var/cache/apk/*

# Set Workdir
WORKDIR /application

# Expose volumes
VOLUME ["/application"]

# Entry point
ENTRYPOINT ["/usr/sbin/php-fpm7"]
