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
    # function error_exit {
    #     echo "$1" 1>&2
    #     echo "Press Enter to exit..."
    #     read
    #     exit 1
    # }
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
    # Install firefox
    # -------------------------\
    # sudo snap disable firefox
    # sudo snap remove --purge firefox
    # # sudo snap remove firefox
    # sudo install -d -m 0755 /etc/apt/keyrings
    # wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
    # gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
    # echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
    # echo '
    # Package: *
    # Pin: origin packages.mozilla.org
    # Pin-Priority: 1000
    # ' | sudo tee /etc/apt/preferences.d/mozilla
    # sudo apt-get update && sudo apt-get install firefox


    # -------------------------
    # Install chrome
    # -------------------------
    echo "Installing google chome ..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
    # sudo dpkg -i google-chrome-stable_current_amd64.deb

    # -------------------------
    # Install audio switcher (support the lower version of 24.04)
    # -------------------------
    # sudo apt-add-repository ppa:yktooo/ppa
    # sudo apt-get update
    # sudo apt-get install -y indicator-sound-switcher

    # -------------------------
    # Install solaar
    # -------------------------
    echo "Installing solaar ..."
    sudo apt install -y solaar

    # -------------------------
    # Install world clock and 
    # tweaks
    # -------------------------
    sudo apt install gnome-clocks
    sudo apt install gnome-tweaks
    # sudo apt install gnome-shell-extensions gnome-shell-extension-prefs chrome-gnome-shell
    sudo apt install gnome-shell-extension-manager
    sudo apt install gnome-weather

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


    # ------------------------
    # Install drawIO
    # ------------------------
    sudo snap install drawio
    # wget https://github.com/jgraph/drawio-desktop/releases/download/v13.0.3/draw.io-amd64-13.0.3.deb
    # sudo dpkg -i draw.io-amd64-13.0.3.deb

    # ------------------------
    # Install GPU driver
    # ------------------------
    # sudo add-apt-repository ppa:graphics-drivers/ppa && sudo apt update
    # sudo apt-get remove --purge '^nvidia-.*'
    # sudo apt install -y nvidia-driver-550

    # ------------------------
    # Install Dropbox
    # ------------------------
    wget -O dropbox_2025.05.20_amd64.deb "https://www.dropbox.com/download?dl=packages%2Fubuntu%2Fdropbox_2025.05.20_amd64.deb"
    sudo apt install -y dropbox_2025.05.20_amd64.deb
    # sudo dpkg -i dropbox_2025.05.20_amd64.deb

    # ------------------------
    # Install Only office
    # ------------------------
    sudo snap install onlyoffice-desktopeditors


    # ------------------------
    # Install thunderbird
    # ------------------------
    sudo apt install thunderbird



    # ------------------------
    # Install Docker
    # ------------------------
    # Add Docker's official GPG key:
    sudo apt-get update

    # Install curl and ca-certificates
    sudo apt-get install ca-certificates curl

    # Create the keyrings folder for key (instead of trusted.gpg before), download the key and save to apt/keyrings under .asc, provide the right
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources: echo write to stdout; "|" get the input on the left to use for
    # the right, provide input to "tee" to write into docker.list apt. /dev/null stop the output to write to terminal
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    
    sudo systemctl status docker  #Check the status of installed docker
    sudo systemctl start docker
    # To avoid using sudo
    sudo chmod 666 /var/run/docker.sock #add current user (recommened)
    
}


# =====================================
#           MAIN
# =====================================
main()
{
    installEnvironment
}

main