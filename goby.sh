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