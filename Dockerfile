FROM 192.168.200.224:8132/docker-hosted/ubuntu:20.04

LABEL maintainer="JalalLinuX"

ARG WWWGROUP

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Asia/Tehran

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -y gnupg gosu curl ca-certificates zip unzip git supervisor sqlite3 libcap2-bin libpng-dev python2
RUN mkdir -p ~/.gnupg
RUN chmod 600 ~/.gnupg
RUN echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf
RUN apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x14AA40EC0831756756D7F66C4F4EA0AAE5267A6C
RUN echo "deb https://ppa.launchpadcontent.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/ppa_ondrej_php.list
RUN apt-get update
RUN apt-get install -y php8.0-cli php8.0-dev
RUN apt-get install -y php8.0-pgsql php8.0-sqlite3 php8.0-gd
RUN apt-get install -y php8.0-curl php8.0-memcached
RUN apt-get install -y php8.0-imap php8.0-mbstring
RUN apt-get install -y php8.0-xml php8.0-zip php8.0-bcmath php8.0-soap
RUN apt-get install -y php8.0-intl php8.0-readline php8.0-pcov
RUN apt-get install -y php8.0-msgpack php8.0-igbinary php8.0-ldap
RUN apt-get install -y php8.0-redis php8.0-swoole
RUN apt-get install -y jpegoptim optipng pngquant gifsicle

RUN pecl channel-update pecl.php.net
RUN pecl install swoole
RUN apt-get install git -y
RUN apt-get install php8.0-dev -y
RUN apt-get install php-pear -y
RUN apt-get install build-essential -y
RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs htop
RUN npm install --location=global npm@latest
RUN npm install --location=global pm2@latest
RUN npm install --location=global svgo
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN echo "deb http://apt.postgresql.org/pub/repos/apt focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN curl --silent -o - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update
RUN apt-get install -y nano wget net-tools
RUN apt-get install -y postgresql-client-14
RUN apt-get -y autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN update-alternatives --set php /usr/bin/php8.0
RUN setcap "cap_net_bind_service=+ep" /usr/bin/php8.0

COPY php.ini /etc/php/8.0/cli/conf.d/99-customize.ini
RUN echo 'alias art="php artisan"' >> ~/.bashrc
