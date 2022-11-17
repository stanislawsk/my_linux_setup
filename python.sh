#!/bin/bash
##############################################
### Upgrade python to the specific version ###
###  Tested on Debian 11 and Ubuntu 22.04  ###
##############################################

# Python version to install
VERSION="3.11.0"
SHORT_VERSION=${VERSION%.*}

# Install the required dependencies to compile the Python source code.
apt update
apt -y install wget build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev

# Install Python in the above version if not installed
# if ! [ -f /usr/local/bin/python$SHORT_VERSION ]; then
if ! command -v python$SHORT_VERSION &> /dev/null || ! python$SHORT_VERSION -V | grep -q $VERSION
then
    # Download python source
    if ! [ -f Python-$VERSION.tar.xz ]; then
        wget https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tar.xz
    fi
    # Compile and install the new python
    tar -xf Python-$VERSION.tar.xz
    cd Python-$VERSION
    ./configure --enable-optimizations
    make altinstall
    cd ../
fi

# If the new python has been installed correctly, set it as default
if [ -f /usr/local/bin/python$SHORT_VERSION ]; then
    # Set new python as default
    update-alternatives --install /usr/bin/python python /usr/local/bin/python$SHORT_VERSION 1
    # Upgrade pip
    /usr/local/bin/python$SHORT_VERSION -m pip install --upgrade pip
    # Set new pip as default
    update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip$SHORT_VERSION 1
else
    echo "Python did not install correctly."
    exit 45
fi

# Remove Python-3.x.x.tar.xz file
if [ -f "Python-$VERSION.tar.xz" ]; then
    rm "Python-$VERSION.tar.xz"
fi
# Remove Python-3.x.x dir
if [ -d "Python-$VERSION" ]; then
    rm -r "Python-$VERSION"
fi

python -V && pip -V