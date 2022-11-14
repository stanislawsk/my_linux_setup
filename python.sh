#!/bin/bash
##################################################
### Install Python in the version given below. ###
##################################################

# Python version to install
VERSION="3.11.0"

apt update
# Install dependencies
apt -y install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev

# Install Python in the above version if not installed
if ! python3.11 --version | grep -q $VERSION; then
    # Download python source
    if ! [ -f Python-$VERSION.tar.xz ]; then
        wget https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tar.xz
    fi
    # Install from source
    if md5sum -c sum/Python-$VERSION.tar.xz.md5sum; then
        tar -xf Python-$VERSION.tar.xz
        cd Python-$VERSION
        ./configure --enable-optimizations
        make -j 7
        make altinstall
        cd ../
    fi
    
fi

# Remove Python-3.x.x.tar.xz file
if [ -f "Python-$VERSION.tar.xz" ]; then
    rm "Python-$VERSION.tar.xz"
fi
# Remove Python-3.x.x dir
if [ -d "Python-$VERSION" ]; then
    rm -r "Python-$VERSION"
fi
# Upgrade pip
python3.11 -m pip install --upgrade pip
# Install all pip packages from PIP_PACKAGES
< PIP_PACKAGES xargs python3.11 -m pip install
