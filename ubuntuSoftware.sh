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
    cd ~/Downloads/
    # -------------------------
    # Install microsoft edge
    # -------------------------
    # sudo apt install -y curl
    # curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    # sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    # sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
    # sudo rm microsoft.gpg
    # sudo apt update && sudo apt install microsoft-edge-stable


    # wget https://go.microsoft.com/fwlink/?linkid=2069148 -O microsoft-edge.deb
    # sudo dpkg -i microsoft-edge.deb


    # -------------------------
    # Install wifi driver
    # -------------------------
    echo "Installing the external wifi driver ..."
    sudo apt-get update
    sudo apt install -y build-essential dkms git iw
    mkdir -p ~/src
    cd ~/src
    echo "Cloning the git file and install the wifi driver"
    git clone https://github.com/morrownr/rtl8852bu.git
    cd ~/src/rtl8852bu
    sudo ./install-driver.sh

    # -------------------------
    # Install chrome
    # -------------------------
    echo "Installing google chome ..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb

    # -------------------------
    # Install solaar
    # -------------------------
    echo "Installing solaar ..."
    sudo apt install -y solaar


    # -------------------------
    # Install unikey
    # -------------------------
    echo "Installing ibus unikey ..."
    sudo apt-get install -y ibus-unikey 
    ibus restart

    # -------------------------
    # Install vscode
    # -------------------------
    echo "Installing vscode ..."
    sudo snap install code --classic

    # -------------------------
    # Install grub=customizer
    # -------------------------
    echo "Installing grub-customizer ..."
    sudo add-apt-repository ppa:danielrichter2007/grub-customizer
    sudo apt update
    sudo apt install -y grub-customizer
    

}


# =====================================
#           MAIN
# =====================================
main()
{
    installEnvironment
}

main