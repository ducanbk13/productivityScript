#!/usr/bin/bash

# Add to the apt proxy
installEnvironment(){

    # ------------------------
    # Stop script if any fault happends
    # ------------------------
    # set -e

    # ------------------------
    # https://github.com/morrownr/rtl8852bu/blob/1.19.3/README.md
    # ------------------------
    function error_exit {
        echo "$1" 1>&2
        echo "Press Enter to exit..."
        read
        exit 1
    }

    read -p "You want to install which source of driver rtl8852bu (type '1') or rtl8852bu (morrownr version,recommemed) (type '0'):" taskState

    mkdir -p ~/Downloads/wifiDriver
    cd ~/Downloads/wifiDriver

    if [ $taskState = "0" ]; then 
        sudo apt-get update
        sudo apt install -y build-essential dkms git iw

        echo "Cloning the git file and install the wifi driver"
        # git clone https://github.com/morrownr/rtl8852bu.git

        git clone https://github.com/morrownr/rtl8852bu-20240418.git
        cd ~/Downloads/wifiDriver/rtl8852bu-20240418
        sudo ./install-driver.sh
    
    elif [ $taskState = "1" ]; then 
        sudo apt-get update
        sudo apt-get install make gcc linux-headers-$(uname -r) build-essential git
        git clone https://github.com/lwfinger/rtl8852bu.git
        cd rtl8852bu
        make
        sudo make install
        
    fi
}


# =====================================
#           MAIN
# =====================================
main()
{
    installEnvironment
}

main