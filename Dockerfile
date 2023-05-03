FROM php:5.6.40-apache-stretch

RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

RUN apt-get update && apt-get install -y libpng-dev
RUN apt-get install -y libonig-dev
RUN apt-get install -y libjpeg-dev
RUN apt-get install -y default-libmysqlclient-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y libfreetype6-dev
RUN apt-get install -y libzip-dev
RUN apt-get install -y cron
RUN apt-get install -y ssmtp
RUN apt-get install -y unzip

RUN curl -fsSL -o oxwall.zip \
      "http://ow.download.s3.amazonaws.com/oxwall-1.8.4.1.zip"
RUN unzip oxwall.zip \
 && rm oxwall.zip


RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mbstring mysql pdo pdo_mysql zip ftp \
    && a2enmod rewrite

COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html/
RUN touch /var/www/crontab \
&& chown www-data:www-data /var/www/crontab \
&& crontab -u www-data /var/www/crontab

EXPOSE 80