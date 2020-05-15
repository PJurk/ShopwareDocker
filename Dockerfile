#FROM shopware/development:latest
FROM php:7.2.30-apache-buster

RUN requirements="libbz2-dev libfreetype6-dev libicu-dev libjpeg62-turbo-dev libssh2-1-dev libsodium-dev  libmcrypt-dev libpng-dev libpng++-dev libzip-dev libmcrypt-dev libmcrypt4 libjpeg-dev libcurl3-dev libfreetype6 libfreetype6-dev libicu-dev libxslt1-dev libssl-dev lsof default-mysql-client unzip gzip curl git" \
    && apt-get -y update \
    && apt-get install -y $requirements \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=DIR \
    && docker-php-ext-install gd \
    pdo_mysql \
    mbstring \
    zip \
    intl \
    xsl \
    soap \
    bcmath \
    sockets \
    curl \
    phar  \
    opcache \
    pcntl \
    gettext \
    bz2 \
    simplexml

RUN pecl channel-update pecl.php.net \
  && pecl install xdebug

RUN docker-php-ext-enable xdebug \
  && sed -i -e 's/^zend_extension/\;zend_extension/g' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs 

RUN curl -sSLO https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 \
  && chmod +x mhsendmail_linux_amd64 \
  && mv mhsendmail_linux_amd64 /usr/local/bin/mhsendmail

RUN curl -sS https://getcomposer.org/installer | \
    php --  --install-dir=/usr/local/bin --filename=composer


RUN echo 127.0.0.1 www.shopware.test.com shopware.test.com >> "/etc/hosts"
COPY "shopware.test.com.conf" "/etc/apache2/sites-available/shopware.test.com.conf"
COPY "apache2.conf" "/etc/apache2/apache2.conf"
RUN rm -rf "/etc/apache2/sites-available/000-default.conf"
RUN rm -rf "/etc/apache2/sites-available/default-ssl.conf"
COPY ./php.ini /usr/local/etc/php/php.ini
WORKDIR /var/www/html
RUN git clone https://github.com/shopware/development.git
RUN mv development/* /var/www/html
RUN rm -rf development
COPY  ./.env.dist /var/www/html/.env.dist 
COPY  ./.psh.yml.dist /var/www/html/.psh.yml.dist
COPY  ./.psh.yml.override /var/www/html/.psh.yml.override