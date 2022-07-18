FROM ubuntu/apache2:2.4-20.04_beta

RUN apt update
RUN apt-get install -y nano

RUN a2enmod ssl

WORKDIR /etc/apache2
