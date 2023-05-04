FROM amd64/ubuntu:20.04

LABEL maintainer="JalalLinuX"

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Asia/Tehran

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -y gnupg gosu curl ca-certificates \
    zip unzip git htop nano wget net-tools iputils-ping \
    supervisor sqlite3 libcap2-bin libpng-dev python2
RUN mkdir -p ~/.gnupg
RUN chmod 600 ~/.gnupg
RUN echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf
RUN apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x14AA40EC0831756756D7F66C4F4EA0AAE5267A6C
RUN echo "deb https://ppa.launchpadcontent.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/ppa_ondrej_php.list
RUN apt-get update
RUN apt-get install -y php8.2-cli php8.2-dev
RUN apt-get install -y php8.2-pgsql php8.2-sqlite3 php8.2-gd
RUN apt-get install -y php8.2-curl php8.2-memcached
RUN apt-get install -y php8.2-imap php8.2-mbstring
RUN apt-get install -y php8.2-xml php8.2-zip php8.2-bcmath php8.2-soap
RUN apt-get install -y php8.2-intl php8.2-readline php8.2-pcov
RUN apt-get install -y php8.2-msgpack php8.2-igbinary php8.2-ldap
RUN apt-get install -y php8.2-redis php8.2-swoole
RUN apt-get install -y jpegoptim optipng pngquant gifsicle

RUN pecl channel-update pecl.php.net
RUN pecl install swoole
RUN apt-get install php8.2-dev -y
RUN apt-get install php-pear -y
RUN apt-get install build-essential -y
RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
RUN npm install --location=global npm@latest
RUN npm install --location=global pm2@latest
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN echo "deb http://apt.postgresql.org/pub/repos/apt focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN curl --silent -o - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update
RUN apt-get install -y postgresql-client-14
RUN apt-get -y autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN update-alternatives --set php /usr/bin/php8.2
RUN setcap "cap_net_bind_service=+ep" /usr/bin/php8.2

COPY php.ini /etc/php/8.2/cli/conf.d/99-customize.ini
RUN echo 'alias art="php artisan"' >> ~/.bashrc
