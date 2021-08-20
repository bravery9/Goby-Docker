FROM ubuntu:18.04
LABEL maintainer="xrsec"
LABEL mail="troy@zygd.site"

COPY goby.sh /

RUN apt update -y && apt upgrade curl wget -y \
    && apt install openssl wget unzip -y \
    && mkdir -p /opt/goby/goby_run.bak \
    && wget https://github.com/gobysec/Goby/releases/download/Beta1.8.298/goby-linux-x64-1.8.298.zip -O /opt/goby/goby-linux-x64-1.8.298.zip \
    && unzip /opt/goby/goby-linux-x64-1.8.298.zip -d /opt/goby/ \
    && mv /opt/goby/goby-linux-x64-1.8.298 /opt/goby/goby_run

ENTRYPOINT ["/goby.sh"]

EXPOSE 8361

STOPSIGNAL SIGQUIT

CMD ["/goby.sh"]