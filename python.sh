#!/bin/bash
##################################################
### Install Python in the version given below. ###
##################################################

# Python version to install
VERSION="3.11.0"

# Install Python in the above version if not installed
if ! [ -x "$(command -v python${VERSION:0:4})" ]; then
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
python${VERSION:0:4} -m pip install --upgrade pip
# Install all pip packages from PIP_PACKAGES
< PIP_PACKAGES xargs python${VERSION:0:4} -m pip install
