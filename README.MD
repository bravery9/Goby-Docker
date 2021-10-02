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
