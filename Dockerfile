FROM debian:buster-slim

LABEL maintainer="diego.souto@gmail.com" \ 
    org.label-schema.name="windscribe-privoxy" \
    org.label-schema.vendor="diegosc78" \
    org.label-schema.description="Docker Windscribe proxy (http and shell) built on Debian buster linux" \
    org.label-schema.license="MIT"

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Madrid \
    PUID=1000 \
    PGID=1000 \
    WINDSCRIBE_USERNAME=xxxxxxxxx \
    WINDSCRIBE_PASSWORD=xxxxxxxxx \
    WINDSCRIBE_PROTOCOL=stealth \
    WINDSCRIBE_PORT=80 \
    WINDSCRIBE_PORT_FORWARD=9999 \
    WINDSCRIBE_LOCATION=FR \
    WINDSCRIBE_LANBYPASS=on \
    WINDSCRIBE_FIREWALL=on

VOLUME [ "/config" ]
EXPOSE 8118/tcp

RUN apt -y update && apt -y upgrade && apt install -y gnupg apt-utils ca-certificates expect iptables iputils-ping dirmngr apt-transport-https curl net-tools iputils-tracepath && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7 && \
    echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections && \
    sh -c "echo 'deb https://repo.windscribe.com/debian buster main' > /etc/apt/sources.list.d/windscribe-repo.list" && \
    apt -y update && apt install -y windscribe-cli && \
    apt -y autoremove && apt -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt -y update && apt -y upgrade && apt install -y privoxy socat && \
    sed -i 's/listen-address\s*127.0.0.1:8118/listen-address 0.0.0.0:8118/g' /etc/privoxy/config && \
    sed -i 's/listen-address\s*\[::1\]:8118/#listen-address [::1]:8118/g' /etc/privoxy/config
#    service privoxy start

RUN groupadd -r docker_group  && useradd -r -d /config -g docker_group docker_user

ADD scripts /opt/scripts/

HEALTHCHECK --interval=5m --timeout=60s CMD /opt/scripts/health-check.sh || exit 1

CMD [ "/bin/bash", "/opt/scripts/vpn-startup.sh" ]