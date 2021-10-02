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

echo "Starting Goby Service"
/opt/goby/goby_run/golib/goby-cmd-linux -apiauth goby:$password -mode api -bind 0.0.0.0:$port