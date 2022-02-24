#!/bin/bash
name0='wget'
name1='Firefox'

dpkg -s $name1 &> /dev/null  

if [ $? -ne 0 ]
    then
        echo "******************************"
        echo "*     Wget not installed     *"
        echo "******************************"
        sudo apt update
        sudo apt install $name
fi

FILE='icaclient_22.2.0.20_amd64.deb'

wget -O "https://downloads.citrix.com/20380/icaclient_22.2.0.20_amd64.deb?__gda__=exp=1645739366~acl=/*~hmac=088391c4224a6abd9a1ecc8c4504f3cd2b1cb11501bc96b612b1703cdf802289"

if [[ -f "$FILE" ]]; then

    sudo dpkg -i icaclient_22.2.0.20_amd64.deb

    dpkg -s $name1 &> /dev/null

    if [ $? -ne 0 ]
        then
            echo "*****************************"
            echo "*   Firefox not installed   *"
            echo "*****************************"
            sudo apt update
            sudo apt install $name
    fi

    sudo ln -s /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts/
    sudo /opt/Citrix/ICAClient/util/./ctx_rehash
    sudo update-ca-certificates
else 
    echo "$FILE does not exist."
    echo "Please download $FILE from: " 
    echo " - https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html"
fi