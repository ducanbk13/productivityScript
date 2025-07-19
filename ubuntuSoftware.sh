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
    # -------------------------
    sudo install -d -m 0755 /etc/apt/keyrings
    wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
    gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
    echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
    echo '
    Package: *
    Pin: origin packages.mozilla.org
    Pin-Priority: 1000
    ' | sudo tee /etc/apt/preferences.d/mozilla
    sudo apt-get update && sudo apt-get install firefox


    # -------------------------
    # Install chrome
    # -------------------------
    echo "Installing google chome ..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb

    # -------------------------
    # Install audio switcher
    # -------------------------
    sudo apt-add-repository ppa:yktooo/ppa
    sudo apt-get update
    sudo apt-get install -y indicator-sound-switcher

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
    wget https://github.com/jgraph/drawio-desktop/releases/download/v13.0.3/draw.io-amd64-13.0.3.deb
    sudo dpkg -i draw.io-amd64-13.0.3.deb

    # ------------------------
    # Install GPU driver
    # ------------------------
    # sudo add-apt-repository ppa:graphics-drivers/ppa && sudo apt update
    # sudo apt-get remove --purge '^nvidia-.*'
    # sudo apt install -y nvidia-driver-550


    

}


# =====================================
#           MAIN
# =====================================
main()
{
    installEnvironment
}

main