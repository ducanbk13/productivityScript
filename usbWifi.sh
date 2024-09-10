#!/usr/bin/bash

# Add to the apt proxy
installEnvironment(){

    # ------------------------
    # Stop script if any fault happends
    # ------------------------
    set -e

    # ------------------------
    # https://github.com/morrownr/rtl8852bu/blob/1.19.3/README.md
    # ------------------------
    function error_exit {
        echo "$1" 1>&2
        echo "Press Enter to exit..."
        read
        exit 1
    }


    sudo apt-get update
    sudo apt install -y build-essential dkms git iw
    mkdir -p ~/src
    cd ~/src
    echo "Cloning the git file and install the wifi driver"
    git clone https://github.com/morrownr/rtl8852bu.git
    cd ~/src/rtl8852bu
    sudo ./install-driver.sh

}


# =====================================
#           MAIN
# =====================================
main()
{
    installEnvironment
}

main