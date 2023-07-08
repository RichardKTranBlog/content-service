# Step 1: Define the base image
FROM php:8.1-fpm

# Install dependencies for the operating system software
RUN apt-get update && apt-get install -y \
    nginx \
    build-essential \
    libpng-dev \
    libxml2-dev \
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

# Step 3: Install required PHP extensions
# RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install composer (php package manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Step 4: Set the working directory
WORKDIR /var/www/html


# Step 5: Copy project files
COPY . .

# Step 6: Set permissions
RUN chown -R www-data:www-data .

USER www-data

RUN composer install \
    --optimize-autoloader \
    --no-dev

USER root

# Remove the default Nginx configuration
RUN rm /etc/nginx/sites-available/default

# Unlink the default Nginx configuration
RUN unlink /etc/nginx/sites-enabled/default

# Step 7: Configure Nginx
COPY docker-nginx-site.conf /etc/nginx/conf.d/default.conf

# Step 8: Expose port
EXPOSE 80

# CMD service nginx start && php-fpm
CMD service nginx start && php-fpm
