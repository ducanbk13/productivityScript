#!/usr/bin/bash

# Add to the apt proxy
installConda(){

    # ------------------------
    # Stop script if any fault happends
    # ------------------------
    set -e

    # ------------------------
    # Check the function is error
    # or not.
    # Explain for the echo "$1" 1>&2 
    # Take the first argument passed to the function.
    # Print that argument as an error message.
    # Redirect the message to standard error.
    # ------------------------
    function error_exit {
        echo "$1" 1>&2
        echo "Press Enter to exit..."
        read
        exit 1
    }
    
    # ------------------------
    # Update and install curl
    # ------------------------
    sudo apt-get update
    sudo apt install -y curl

    
    # ------------------------
    # jump to tmp and download 
    # anaconda, then build
    # ------------------------
    cd // && cd tmp
    curl https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh --output anaconda.sh
    sha256sum anaconda.sh || error_exit "Can't run sha256sum anaconda.sh"

    export PATH=~/anaconda3/bin:$PATH || error_exit "export PATH error"
    bash anaconda.sh || error_exit "Can't run bash anaconda.sh"
    
    
    # Send "yes" after the 64th Enter
    # expect {
    #     "Please answer 'yes' or 'no':" { send "yes\r" }
    
    # # ------------------------
    # # export the PATH to use 
    # # entire system
    # # ------------------------
    # export PATH=~/anaconda3/bin:$PATH || error_exit "export PATH error"
    
    # cd ~/anaconda || error_exit "no ~/anaconda directory"

    # source activate || error_exit "can't activate the environment"

}


# =====================================
#           MAIN
# =====================================
main()
{
    installConda
}

main