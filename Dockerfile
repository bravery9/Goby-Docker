FROM nginx:alpine
LABEL maintainer="xrsec"
LABEL mail="troy@zygd.site"

COPY ./docker-entrypoint.sh /
COPY ./Dockerfile /opt/goby/
COPY ./conf.d/default.conf /etc/nginx/conf.d/
COPY ./docker-entrypoint.sh /


RUN apk add --update openssl wget unzip && \
    rm -rf /var/cache/apk/* \
    && mkdir -p /opt/goby/goby_run.bak \
    && wget https://github.com/gobysec/Goby/releases/download/Beta1.8.298/goby-linux-x64-1.8.298.zip -O /opt/goby/goby-linux-x64-1.8.298.zip \
    && unzip /opt/goby/goby-linux-x64-1.8.298.zip -d /opt/goby/ \
    && mv /opt/goby/goby-linux-x64-1.8.298 /opt/goby/goby_run

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]