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
        read
        exit 1
    }

    # ------------------------
    # Name of the conda environment
    # and Python version
    # ------------------------
    ENV_NAME="tensorflow2.10.0New"
    PYTHON_VERSION="3.10.12"
    CUDATOOLKIT_VERSION="11.2.0"
    CUDNN_VERSION="8.1.0.77"
    TENSORFLOW_VERSION="2.10.0"
    KERAS_VERSION="2.10.0"


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
    # Assign the version of numpy
    # and pandas to avoid problems
    pip install numpy==1.21.6
    pip install pandas==1.5.2
    pip install matplotlib==3.5.3
    pip install joblib==1.4.2
    pip install tables==3.8.0 --no-deps
    pip install py-cpuinfo==6.0.0 Cython==0.29.26 blosc2==2.0.0 numexpr==2.8.0 
    pip install scipy==1.7.2
    pip install scikit-learn==1.0.2
    pip install prettytable==2.2.1
    # pip install numba==0.55.2
    # pip install umap-learn==0.4.6
    # pip install blosc2==2.0.0
    # pip install Cython==0.29.26
    # pip install py-cpuinfo==6.0.0
    # ------------------------
    # Install cudatoolkit and 
    # cudnn
    # ------------------------
    echo "Installing cudatoolkit version '$CUDATOOLKIT_VERSION' and cudnn version '$CUDNN_VERSION'..."
    # conda install -y -c conda-forge cudatoolkit=$CUDATOOLKIT_VERSION cudnn=$CUDNN_VERSION || error_exit "Failed to install CUDA and CUDNN"
    conda install -y conda-forge::cudatoolkit=$CUDATOOLKIT_VERSION || error_exit "Failed to install CUDA"
    conda install -y conda-forge::cudnn=$CUDNN_VERSION  || error_exit "Failed to install cuda and CuDNN"
    


    # ------------------------
    # Configure the system paths. 
    # ------------------------
    echo "Configure the system paths"
    mkdir -p $CONDA_PREFIX/etc/conda/activate.d
    echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/' > $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh

    # ------------------------
    # Upgrade pip and install
    # tensorflow
    # ------------------------
    echo "Upgrade pip and install tensorflow version '$TENSORFLOW_VERSION'..."
    pip install --upgrade pip
    pip install tensorflow==$TENSORFLOW_VERSION || error_exit "Failed to install TensorFlow"
    # pip install keras==$KERAS_VERSION || error_exit "Failed to install keras"

    

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