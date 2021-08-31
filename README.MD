# Goby Server By Docker

## About

> Attack surface mapping
>
> The new generation of network security technology achieves rapid security emergency through the establishment of a complete asset database for the target.

![image-20210820133955505](https://rmt.ladydaily.com/fetch/ZYGG/storage/image-20210820133955505.png?w=1280)

### Info

```ini
127.0.0.1:15001
Username: goby
Password: docker logs goby | grep " Goby_PassWord :"
```

Github : https://github.com/XRSec/Goby-Docker.git

## Use

### InStall

```bash
docker run -it --name goby -p 15001:15001 -e password=password -e port=15001 xrsec/goby:latest
# Installing containers or updating goby requires downloading resources from GitHub
# -e password=password Set your password here 
# [ -p 15001:15001 | -e port=15001 ] Recommended port consistency
# --restart=always  Automatic restart
```

![image-20210820171215830](https://rmt.ladydaily.com/fetch/ZYGG/storage/20210820171444750926.png?w=1280&fmt=jpg)

### Goby_Desktop

![image-20210820171402647](https://rmt.ladydaily.com/fetch/ZYGG/storage/20210820171449669292.png?w=1280&fmt=jpg)

## The build Process

### Dockerfile

```dockerfile
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
```



### goby.sh

```sh
#!/bin/bash
clear
echo -e "\033[1;31m    _____    ____    ____   __     __ \033[0m"
echo -e "\033[1;32m   / ____|  / __ \  |  _ \  \ \   / / \033[0m"
echo -e "\033[1;33m  | |  __  | |  | | | |_) |  \ \_/ /  \033[0m"
echo -e "\033[1;34m  | | |_ | | |  | | |  _ <    \   /   \033[0m"
echo -e "\033[1;35m  | |__| | | |__| | | |_) |    | |    \033[0m"
echo -e "\033[1;36m   \_____|  \____/  |____/     |_|    \033[0m"                                
echo -e "\033[1;34m -------------- \033[0m"                           
echo -e "\033[1;31m __  __  ____                      \033[0m"
echo -e "\033[1;32m \ \/ / |  _ \   ___    ___    ___  \033[0m"
echo -e "\033[1;33m  \  /  | |_) | / __|  / _ \  / __| \033[0m"
echo -e "\033[1;34m  /  \  |  _ <  \__ \ |  __/ | (__  \033[0m"
echo -e "\033[1;35m /_/\_\ |_| \_\ |___/  \___|  \___| \n\033[0m"
echo -e "\033[1;31m Thank's fahai && TimeLine Sec \n\033[0m"
echo -e "\033[1;32m [ help ] \033[0m"
echo -e "\033[1;32m Goby_PassWord : $password        \033[0m"

# Goby update

echo "Check the update ..."
# /opt/goby
goby_url=`curl -s https://api.github.com/repos/gobysec/Goby/releases/latest | grep browser_download_url | grep linux | cut -d '"' -f 4`
# goby-linux-x64-1.8.298.zip
goby_version=`echo $goby_url |  cut -d "/" -f 9`
goby_dir=`echo $goby_version | sed 's/\.zip//g'`

if [[ ! -f "/opt/goby/$goby_version" ]]; then
    # File not found
    rm -rf /opt/goby/goby-linux-x64*.zip
    wget $goby_url -O /opt/goby/$goby_version
    unzip /opt/goby/$goby_version -d /opt/goby/
    if [[ ! -f "/opt/goby/goby_run" ]]; then
        mv /opt/goby/$goby_dir /opt/goby/goby_run
    else 
        mv /opt/goby/goby_run /opt/goby/goby_run.bak
        mv /opt/goby/$goby_dir /opt/goby/goby_run
        echo "Successful migration!"
    fi
    echo "Update complete!"
else
    #  File exists
    echo "It's already the latest edition!"
fi

# Start Goby

echo "Starting Goby Service"
/opt/goby/goby_run/golib/goby-cmd-linux -apiauth goby:$password -mode api -bind 0.0.0.0:$port
```



## Compile again

Github : https://github.com/XRSec/Goby-Docker.git

```bash
git clone https://github.com/XRSec/Goby-Docker.git
cd AWVS14-Docker
docker build -t goby:latest .
```



## Thanks to the list

Gobysec : https://github.com/gobysec/Goby

Vipersec : https://www.yuque.com/vipersec
