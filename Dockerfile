FROM ubuntu:18.04
LABEL maintainer="xrsec"
LABEL mail="troy@zygd.site"

COPY goby.sh /
COPY . /opt/goby

RUN apt update -y && apt upgrade curl wget -y \
    && apt install openssl wget unzip -y \
    && wget `curl -s https://api.github.com/repos/gobysec/Goby/releases/latest | grep browser_download_url | grep linux | cut -d '"' -f 4` -O /opt/goby/goby-linux-x64.zip \
    && unzip /opt/goby/goby-linux-x64.zip -d /opt/goby/ \
    && mv /opt/goby/`echo \`curl -s https://api.github.com/repos/gobysec/Goby/releases/latest | grep "browser_download_url"| grep linux | cut -d '"' -f 4 |  cut -d "/" -f 9\` | sed 's/\.zip//g'` /opt/goby/goby_run

ENTRYPOINT ["/goby.sh"]

EXPOSE 8361

STOPSIGNAL SIGQUIT

CMD ["/goby.sh"]