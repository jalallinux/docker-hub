FROM amd64/ubuntu:20.04

LABEL maintainer="JalalLinuX"

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Asia/Tehran
ENV CONFLUENCE_VERSION=8.7.1

COPY install /tmp/install

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get update && \
    apt-get install -y gnupg gosu curl ca-certificates \
        zip unzip git htop nano wget net-tools iputils-ping \
        supervisor sqlite3 libcap2-bin libpng-dev python2 fontconfig expect && \
    mkdir -p ~/.gnupg && \
    chmod 600 ~/.gnupg && \
    echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf && \
    apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x14AA40EC0831756756D7F66C4F4EA0AAE5267A6C && \
    apt-get update && \
    wget -O /tmp/atlassian-confluence-software-installation https://product-downloads.atlassian.com/software/confluence/downloads/atlassian-confluence-${CONFLUENCE_VERSION}-x64.bin && \
    chmod a+x /tmp/install && \
    chmod a+x /tmp/atlassian-confluence-software-installation && \
    /tmp/install && \
    rm -f /opt/atlassian/confluence/atlassian-confluence/WEB-INF/lib/atlassian-extras-3.4.6.jar && \
    rm -f /opt/atlassian/confluence/logs/catalina.out

COPY atlassian-extras-3.4.6.jar /opt/atlassian/confluence/atlassian-confluence/WEB-INF/lib/atlassian-extras-3.4.6.jar
# RUN wget -O /opt/atlassian/confluence/atlassian-confluence/WEB-INF/lib/atlassian-extras-3.4.6.jar https://omwtfyb.ir/atlassian-extras-3.4.6.jar

RUN /opt/atlassian/confluence/bin/start-confluence.sh && /opt/atlassian/confluence/bin/stop-confluence.sh && \
    ln -sf /dev/stdout /opt/atlassian/confluence/logs/catalina.out && \
    ln -sf /dev/stderr /opt/atlassian/confluence/logs/catalina.out

EXPOSE 8090

CMD [ "/opt/atlassian/confluence/bin/start-confluence.sh", "-fg" ]