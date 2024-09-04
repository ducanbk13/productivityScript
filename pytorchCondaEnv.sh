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
    ENV_NAME="pytorch2.3.1"
    PYTHON_VERSION="3.12"
    PYTORCH_VERSION="2.3.1"

    CUDA_VERSION="12.1"
    TORCHVISION_VERSION="0.18.1"
    TOURCHAUDIO_VERSION="2.3.1"


    # Check if conda is installed
    if ! command -v conda &> /dev/null; then
        error_exit "Conda is not installed. Please install Anaconda or Miniconda first."
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
    # Install pytorch with cuda
    # ------------------------
    echo "Installing pytorch version '$PYTORCH_VERSION' and CUDA version '$CUDA_VERSION'..."
    # conda install -y -c conda-forge cudatoolkit=$CUDATOOLKIT_VERSION cudnn=$CUDNN_VERSION || error_exit "Failed to install CUDA and CUDNN"
    conda install -y pytorch==$PYTORCH_VERSION torchvision==$TORCHVISION_VERSION torchaudio==$TOURCHAUDIO_VERSION pytorch-cuda=$CUDA_VERSION -c pytorch -c nvidia

    # ------------------------
    # Install other packages
    # ------------------------
    # conda install -y conda-forge::matplotlib
    # conda install -y anaconda::pandas
    # conda install -y conda-forge::joblib
    # conda install -y pytables
    # conda install -y anaconda::seaborn
    # conda install -y anaconda::scipy

}


# =====================================
#           MAIN
# =====================================
main()
{
    installEnvironment
}

main