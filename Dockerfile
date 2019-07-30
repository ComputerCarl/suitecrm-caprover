FROM php:7.1.30-apache
# 7.3 fails PHP sessions
# FROM php:7.3.6-apache-stretch

ENV DOWNLOAD_URL https://suitecrm.com/files/162/SuiteCRM-7.11/448/SuiteCRM-7.11.6.zip
ENV DOWNLOAD_FILE SuiteCRM-7.11.6.zip
ENV EXTRACT_FOLDER SuiteCRM-7.11.6
ENV WWW_FOLDER /var/www/html
ENV WWW_USER www-data
ENV WWW_GROUP www-data

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nano libzip-dev libcurl4-gnutls-dev libpng-dev libssl-dev libc-client2007e-dev libkrb5-dev unzip cron re2c python tree && \
    docker-php-ext-configure imap --with-imap-ssl --with-kerberos && \
    docker-php-ext-install mysqli curl gd zip mbstring imap pdo pdo_mysql && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmps

RUN curl -o $DOWNLOAD_FILE -L "${DOWNLOAD_URL}" && \
  unzip $DOWNLOAD_FILE && \
  rm $DOWNLOAD_FILE && \
  rm -rf ${WWW_FOLDER}/* && \
  cp -R ${EXTRACT_FOLDER}/* ${WWW_FOLDER}/ && \
  chown -R ${WWW_USER}:${WWW_GROUP} ${WWW_FOLDER}/* && \
  chown -R ${WWW_USER}:${WWW_GROUP} ${WWW_FOLDER}


WORKDIR /usr/local/etc/php
RUN cp php.ini-production php.ini
ADD php.ini /usr/local/etc/php/conf.d/override.ini

EXPOSE 80