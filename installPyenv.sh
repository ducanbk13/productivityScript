#!/usr/bin/bash

# Add to the apt proxy
installPyEnv(){

    # ------------------------
    # Stop script if any fault happends
    # ------------------------
    # set -e

    # ------------------------
    # Check the function is error
    # or not.
    # Explain for the echo "$1" 1>&2 
    # Take the first argument passed to the function.
    # Print that argument as an error message.
    # Redirect the message to standard error.
    # ------------------------
    # function error_exit {
    #     echo "$1" 1>&2
    #     echo "Press Enter to exit..."
    #     read
    #     exit 1
    # }
    
    # ------------------------
    # Update and install curl
    # ------------------------
    sudo apt-get update
    sudo apt install -y curl

    # ------------------------
    # Install dependencies for Python
    # ------------------------
    echo "==> Installing prerequisites…"
    sudo apt-get install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    

    # ------------------------
    # jump to Downloads and download 
    # pyenv, then build
    # ------------------------
    echo "==> Running pyenv installer…"
    cd ~ && cd Downloads
    curl -fsSL https://pyenv.run | bash                       # downloads the file and run bash directly
    
    # If downloading the file 
    # curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash


    # ------------------------
    # Export PATH to the file
    # ------------------------
    echo "==> Checking Pyenv installation..."

    echo '# >>> Pyenv initialize >>>' >> ~/.bashrc

    if ! grep -Fxq 'export PATH="$HOME/.pyenv/bin:$PATH"' ~/.bashrc; then
        echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
    fi

    if ! grep -Fxq 'eval "$(pyenv init --path)"' ~/.bashrc; then
        echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
    fi

    echo '# >>> Pyenv end initialize >>>' >> ~/.bashrc


    # ------------------------
    # Executing and updating
    # ------------------------
    echo "✅ Pyenv is executing and updating ..."
    source ~/.bashrc        # load changes into the current shell
    # exec "$SHELL"
    pyenv update

    echo -e "\033[32m✅ Pyenv updated!\033[0m"

}


# =====================================
#           MAIN
# =====================================
main()
{
    installPyEnv
}

main