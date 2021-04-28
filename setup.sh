#!/usr/bin/env bash

# Set variables
echo "==================== SETTING VARIABLES ===================="
export PHP_VERSION=7.4

# Update package index
echo "==================== UPDATING PACKAGE INDEX ===================="
apt-get update

# Install common software
echo "==================== INSTALLING COMMON SOFTWARE ===================="
export DEBIAN_FRONTEND=noninteractive
apt-get install -y \
    wget \
    curl \
    zip \
    unzip \
    build-essential \
    lsb-release \
    ca-certificates \
    apt-transport-https \
    software-properties-common

# Install nginx
echo "==================== INSTALLING NGINX ===================="
apt-get update
apt-get install -y nginx

# Install php and required extensions
echo "==================== INSTALLING PHP AND REQUIRED EXTENSIONS ===================="
export DEBIAN_FRONTEND=noninteractive
add-apt-repository ppa:ondrej/php
apt-get update
apt-get install -y \
    php${PHP_VERSION} \
    php${PHP_VERSION}-common \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-cgi \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-bcmath \
    php${PHP_VERSION}-bz2 \
    php${PHP_VERSION}-readline \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-gmp \
    php${PHP_VERSION}-imagick \
    php${PHP_VERSION}-imap

# Set php-fpm
echo "==================== SETTING PHP-FPM ===================="
apt-get install -y php${PHP_VERSION}-fpm
mkdir -p /var/run/php

# Install composer
echo "==================== INSTALLING COMPOSER ===================="
EXPECTED_CHECKSUM="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [[ "$EXPECTED_CHECKSUM" == "$ACTUAL_CHECKSUM" ]]
then
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer
fi

rm composer-setup.php

# Install supervisor
apt-get install -y supervisor
mkdir -p /var/log/supervisor

# Clean
echo "==================== CLEANING FILES ===================="
rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*
