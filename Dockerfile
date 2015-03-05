FROM debian:squeeze
MAINTAINER Fuyuan Cheng <gloomcheng@netivism.com.tw>

# Timeout issues with http.debian.net
RUN sed -i.bak 's/http.debian.net/debian.gtisc.gatech.edu/' /etc/apt/sources.list

# Retrieve PHP 5.2 from Lenny
ADD lenny-list /etc/apt/sources.list.d/
ADD lenny-php /etc/apt/preferences.d/

# Install apache, PHP, and supplimentary programs.
RUN apt-get update \
    && apt-get install -y \
        apache2 \
        libapache2-mod-php5 \
        php5 \
        php5-mysql \
        php5-gd \
        php5-suhosin \
        php-pear \
        php-apc \
        php5-curl \
        curl \
        lynx-cur \
        mysql-server \
        mysql-client
#    && apt-get clean \

# Enable apache mods.
RUN a2enmod php5
RUN a2enmod rewrite

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Add MySQL scripts
ADD run-mysql.sh /run-mysql.sh
RUN chmod 755 /run-mysql.sh

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default

# By default, simply start mysql and apache.
EXPOSE 80
CMD /run-mysql.sh
CMD /usr/sbin/apache2ctl -D FOREGROUND
