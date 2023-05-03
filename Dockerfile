FROM php:7.4-apache-bullseye
# RUN apt-get update && apt-get install -y \
#     libpng-dev \
#     libonig-dev \
#     libjpeg-dev \
#     default-libmysqlclient-dev \
#     libssl-dev \
#     php7-mysql \
#     php7-gd \
#     libfreetype6-dev \
#     libzip-dev \
#     cron \
#     ssmtp

RUN apt-get update && apt-get install -y libpng-dev
RUN apt-get install -y libonig-dev
RUN apt-get install -y libjpeg-dev
RUN apt-get install -y default-libmysqlclient-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y php7-mysql
RUN apt-get install -y php7-gd
RUN apt-get install -y libfreetype6-dev 
RUN apt-get install -y libzip-dev
RUN apt-get install -y cron
RUN apt-get install -y ssmtp

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mbstring mysqli pdo pdo_mysql zip ftp \
    && a2enmod rewrite


COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html/
EXPOSE 80
