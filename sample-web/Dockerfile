FROM php:8.2-apache-bullseye
COPY ./sample-web /var/www/html
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf
RUN docker-php-ext-install mysqli
USER 1001
EXPOSE 8080