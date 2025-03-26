FROM amd64/ubuntu:24.04

LABEL maintainer="JalalLinuX"

ARG NODE_VERSION=22
ARG POSTGRES_VERSION=16

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tehran
ENV COMPOSER_ALLOW_SUPERUSER=1

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get update \
    && apt-get install -y gnupg gosu build-essential curl ca-certificates zip unzip git htop nano wget netcat-openbsd ncdu net-tools iputils-ping supervisor sqlite3 libcap2-bin libpng-dev python3 dnsutils librsvg2-bin \
    && curl -sS 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x14aa40ec0831756756d7f66c4f4ea0aae5267a6c' | gpg --dearmor | tee /etc/apt/keyrings/ppa_ondrej_php.gpg > /dev/null \
    && echo "deb [signed-by=/etc/apt/keyrings/ppa_ondrej_php.gpg] https://ppa.launchpadcontent.net/ondrej/php/ubuntu noble main" > /etc/apt/sources.list.d/ppa_ondrej_php.list \
    && apt-get update \
    && apt-get install -y php8.4-cli php8.4-dev \
        php8.4-pgsql php8.4-sqlite3 php8.4-gd php8.4-imagick \
        php8.4-curl php8.4-memcached php8.4-imap \
        php8.4-mbstring php8.4-xml php8.4-zip  \
        php8.4-bcmath php8.4-soap php8.4-intl \
        php8.4-readline php8.4-pcov php8.4-memcached \
        php8.4-msgpack php8.4-igbinary php8.4-ldap \
        php8.4-redis php8.4-swoole \
    && curl -sLS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer \
    && curl -sLS https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm \
    && npm install -g pm2 \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /etc/apt/keyrings/yarn.gpg >/dev/null \
    && echo "deb [signed-by=/etc/apt/keyrings/yarn.gpg] https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
    && curl -sS https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | tee /etc/apt/keyrings/pgdg.gpg >/dev/null \
    && echo "deb [signed-by=/etc/apt/keyrings/pgdg.gpg] http://apt.postgresql.org/pub/repos/apt noble-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && apt-get update \
    && apt-get install -y yarn \
    && apt-get install -y mysql-client \
    && apt-get install -y postgresql-client-$POSTGRES_VERSION \
    && apt-get install -y --no-install-recommends ffmpeg \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && setcap "cap_net_bind_service=+ep" /usr/bin/php8.4 \
    && update-alternatives --set php /usr/bin/php8.4 \
    && echo 'alias art="php artisan"' >> ~/.bashrc \
    && sed -i 's/opcache.jit=off/;opcache.jit=off/' /etc/php/8.4/cli/conf.d/10-opcache.ini

COPY php.ini /etc/php/8.4/cli/conf.d/99-customize.ini
COPY start-container /usr/local/bin/start-container
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8000
ENTRYPOINT ["/usr/local/bin/start-container"]
