FROM php:7.2-apache
WORKDIR /var/www/html

RUN a2enmod rewrite


# Linux Library
RUN apt-get update -y && apt-get install -y \
    libicu-dev \
    libmariadb-dev \
    unzip zip \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev 
    
#install some base extensions
RUN apt-get install -y \
    libzip-dev \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# PHP Extension
RUN docker-php-ext-install gettext intl pdo_mysql gd

RUN docker-php-ext-configure gd
RUN docker-php-ext-install -j$(nproc) gd
