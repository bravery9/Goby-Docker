#!/bin/sh
# vim:sw=4:ts=4:et

# init
clear
if [[ ! -f "/opt/goby/passwd" ]]; then
    Goby_PassWord=`openssl rand -hex 10`
    echo $Goby_PassWord > /opt/goby/passwd
    echo "PassWord init Successful"
else
    Goby_PassWord=`cat /opt/goby/passwd`
fi
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
echo -e "\033[1;32m Goby_PassWord : $Goby_PassWord        \033[0m"


set -e

# Certificate of judgment

if [[ ! -f "/etc/ssl/ca.key" ]]; then
    # File not found
    # by vipersec

    Echo_c(){
        echo "\033[1;33m\n$1\n\033[0m"
    }

    Rand_Name(){
        openssl rand -base64 8 | md5sum | cut -c1-8
    }

    Gen_Cert(){
        openssl rand -writerand /root/.rnd
        rndca=$(Rand_Name)

        openssl genrsa -out /etc/ssl/ca.key 4096
        # openssl req -new  -x509 -days 3650 -key ca.key -out ca.crt -subj /C=CN/ST=$rndca/L=$rndca/O=$rndca/OU=$rndca/CN=$rndca
        openssl req -new -key /etc/ssl/ca.key -out /etc/ssl/ca.csr -subj /C=CN/ST=$rndca/L=$rndca/O=$rndca/OU=$rndca/CN=$rndca
        openssl x509 -req -in /etc/ssl/ca.csr -out /etc/ssl/ca.crt -signkey /etc/ssl/ca.key -days 3650
    }
    Gen_Cert
    echo "Certificate is generated successfully."
else
#  File exists
    echo "The certificate is ok!"
fi

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
nohup /opt/goby/goby_run/golib/goby-cmd-linux -mode api -apiauth goby:$Goby_PassWord >/opt/goby/goby.log 2>&1 &
echo "Goby Done"


# nginx default

if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
    exec 3>&1
else
    exec 3>/dev/null
fi

if [ "$1" = "nginx" -o "$1" = "nginx-debug" ]; then
    if /usr/bin/find "/docker-entrypoint.d/" -mindepth 1 -maxdepth 1 -type f -print -quit 2>/dev/null | read v; then
        echo >&3 "$0: /docker-entrypoint.d/ is not empty, will attempt to perform configuration"

        echo >&3 "$0: Looking for shell scripts in /docker-entrypoint.d/"
        find "/docker-entrypoint.d/" -follow -type f -print | sort -V | while read -r f; do
            case "$f" in
                *.sh)
                    if [ -x "$f" ]; then
                        echo >&3 "$0: Launching $f";
                        "$f"
                    else
                        # warn on shell scripts without exec bit
                        echo >&3 "$0: Ignoring $f, not executable";
                    fi
                    ;;
                *) echo >&3 "$0: Ignoring $f";;
            esac
        done

        echo >&3 "$0: Configuration complete; ready for start up"
    else
        echo >&3 "$0: No files found in /docker-entrypoint.d/, skipping configuration"
    fi
fi

exec "$@"
