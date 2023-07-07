FROM arm64v8/php:8.1-fpm

# Set working directory
WORKDIR /var/www/html/

USER root

# Copy composer.lock and composer.json into the working directory
COPY composer.json ./

# Install dependencies for the operating system software
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    libzip-dev \
    unzip \
    git \
    libonig-dev \
    curl

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions for php
RUN docker-php-ext-install pdo_mysql zip exif pcntl sockets bcmath
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd

# Install composer (php package manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy existing application directory contents to the working directory
COPY . ./
#Copy existing application directory permissions
# COPY --chown=khoatran:khoatran . /var/www/html

RUN chown -R www-data:www-data .

# Expose port 9000 and start php-fpm server (for FastCGI Process Manager)
EXPOSE 9000

USER www-data

CMD ["php-fpm"]
