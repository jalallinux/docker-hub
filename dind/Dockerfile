FROM amd64/ubuntu:20.04

LABEL maintainer="JalalLinuX"

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Asia/Tehran

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    # Install OS packages
    && apt-get update \
    && apt-get install -y build-essential curl zip unzip git htop nano wget netcat ncdu net-tools iputils-ping supervisor dnsutils ca-certificates apt-transport-https software-properties-common sqlite3 libcap2-bin libpng-dev python3 dnsutils librsvg2-bin \
    # Install Docker
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" \
    && apt-get install -y docker-ce \
    && service docker start \
    # Install Docker Compose
    && curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose
