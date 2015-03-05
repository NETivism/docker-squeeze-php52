FROM debian:squeeze
MAINTAINER Fuyuan Cheng <gloomcheng@netivism.com.tw>

# Install apache first
RUN apt-get update \
    && apt-get install -y \
        apache2
    && apt-get clean

# Use lenny repository for PHP 5.2.17 and install PHP.
ADD lenny-sources.list /etc/apt/sources.list
ADD php.conf /etc/apt/preferences.d/php.conf
RUN apt-get update \
    && apt-get install -y \
        libapache2-mod-php5 \
        php5 \
        php5-mysql \
        php5-gd \
        php5-suhosin \
        php-pear \
        php5-curl \
    && apt-get clean

# Use squeeze repository for other supplimentary programs.
ADD squeeze-sources.list /etc/apt/sources.list
RUN apt-get update \
    && apt-get install -y \
        curl \
        lynx-cur

# Enable apache mods.
RUN a2enmod php5
RUN a2enmod rewrite

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default

# By default, simply start mysql and apache.
EXPOSE 80
CMD /usr/sbin/apache2ctl -D FOREGROUND
