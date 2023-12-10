FROM amd64/ubuntu:20.04

LABEL maintainer="JalalLinuX"

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Asia/Tehran
ENV JIRA_VERSION=9.12.0

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
    wget -O /tmp/atlassian-jira-software-installation https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-${JIRA_VERSION}-x64.bin && \
    chmod a+x /tmp/install && \
    chmod a+x /tmp/atlassian-jira-software-installation && \
    /tmp/install && \
    rm -f /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/atlassian-extras-3.4.6.jar && \
    rm -f /opt/atlassian/jira/logs/catalina.out

COPY atlassian-extras-3.4.6.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/atlassian-extras-3.4.6.jar
# RUN wget -O /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/atlassian-extras-3.4.6.jar https://omwtfyb.ir/atlassian-extras-3.4.6.jar

RUN /opt/atlassian/jira/bin/start-jira.sh && /opt/atlassian/jira/bin/stop-jira.sh && \
    ln -sf /dev/stdout /opt/atlassian/jira/logs/catalina.out && \
    ln -sf /dev/stderr /opt/atlassian/jira/logs/catalina.out

EXPOSE 8080

CMD [ "/opt/atlassian/jira/bin/start-jira.sh", "-fg" ]