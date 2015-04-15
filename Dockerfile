FROM debian:squeeze
MAINTAINER Fuyuan Cheng <gloomcheng@netivism.com.tw>

# Use lenny repository for PHP 5.2.17.
RUN echo "deb http://archive.debian.org/debian lenny main contrib non-free" >> /etc/apt/sources.list
ADD sources/apt/lenny /etc/apt/preferences.d/
RUN apt-get update \
    && apt-get install -y \
        apache2 \
        libapache2-mod-php5 \
        php5-common \
        php5-curl \
        php5-gd \
        php5-mcrypt \
        php5-mysql \
        php5-curl \
        php5-cli \
        curl \
        lynx-cur \
        vim \
        git-core \
        wget && \
  a2enmod php5 && a2enmod rewrite && \
  rm -f /etc/apache2/sites-enabled/000-default && \
  git clone https://github.com/NETivism/docker-sh.git /home/docker

### Apache
# Enable apache mods.
ADD sources/apache/security.conf /etc/apache2/conf.d/security.conf

ENV \
  APACHE_RUN_USER=www-data \
  APACHE_RUN_GROUP=www-data \
  APACHE_LOG_DIR=/var/log/apache2 \
  APACHE_LOCK_DIR=/var/lock/apache2 \
  APACHE_PID_FILE=/var/run/apache2.pid

### MySQL
# Install MySQL server and client.
RUN apt-get install -y \
     mysql-server \
     mysql-client

### 
WORKDIR /home/docker
