#!/usr/bin/bash

# Add to the apt proxy
installEnvironment(){

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
    # Name of the conda environment
    # and Python version
    # ------------------------
    ENV_NAME="tensorflowNewest"
    PYTHON_VERSION="3.12"
    # CUDATOOLKIT_VERSION="11.2.0"
    # CUDNN_VERSION="8.1.0.77"
    # TENSORFLOW_VERSION="2.10.0"
    # KERAS_VERSION="2.10.0"


    # Check if conda is installed
    if ! command -v conda &> /dev/null; then
        error_exit "Conda is not installed. Please install Anaconda or Miniconda first."
    fi

    # ------------------------
    # Check if the environment exists
    # ------------------------
    if conda env list | grep -q "^$ENV_NAME"; then
        echo "Environment '$ENV_NAME' exists. Removing..."
        conda env remove --name "$ENV_NAME"
        echo "Environment '$ENV_NAME' has been removed."
    else
        echo "Environment '$ENV_NAME' does not exist, creating a new one"
    fi

    # ------------------------
    # Create a conda environment
    # with the specified name and
    # Python version
    # ------------------------
    echo "Creating conda environment '$ENV_NAME' with Python $PYTHON_VERSION..."
    conda create -y --name $ENV_NAME python=$PYTHON_VERSION || error_exit "Failed to create conda environment"   # Use or: if the first command is fail, the second one will be conducted

    # ------------------------
    # Activate the conda environment
    # ------------------------
    echo "Activating the conda environment..."
    # source "$(conda info --base)/etc/profile.d/conda.sh"
    conda activate $ENV_NAME || error_exit "Failed to activate conda environment"

    # ------------------------
    # Upgrade pip and install
    # tensorflow
    # ------------------------
    echo "Upgrade pip and install tensorflow..."
    pip install --upgrade pip
    pip install tf-nightly[and-cuda]
    # pip install tensorflow[and-cuda]


    # ------------------------
    # Install package 
    # ------------------------
    pip install joblib
    pip install pandas
    pip install tqdm
    pip install matplotlib
    pip install tkan
    pip install tables
}


# =====================================
#           MAIN
# =====================================
main()
{
    installEnvironment
}

main