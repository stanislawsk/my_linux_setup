#!/bin/bash
##################################################
### Install Python in the version given below. ###
##################################################

# Python version to install
VERSION="3.11.0"

# Install wget if not installed
if ! wget --version | grep -q "GNU Wget"; then
    apt -y install wget
fi
# Install gcc if not installed
if ! gcc --version | grep -q "Free Software"; then
    apt -y install gcc
fi
# Install make if not installed
if ! make --version | grep -q "GNU Make"; then
    apt -y install make
fi
# Install xz-utils if not installed
if ! apt show xz-utilsn | grep -q "Package: xz-utils"; then
    apt -y install xz-utils
fi

# Install Python in the above version if not installed
if ! python3 --version | grep -q $VERSION; then
    rm -rf /usr/local/lib/python3*
    rm -rf /usr/local/bin/python3*
    # Download python source
    if ! [ -f Python-$VERSION.tar.xz ]; then
        wget https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tar.xz
    fi
    # Install from source
    if md5sum -c sum/Python-$VERSION.tar.xz.md5sum; then
        tar -xf Python-$VERSION.tar.xz
        cd Python-$VERSION
        ./configure
        make install
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
python3 -m pip install --upgrade pip
# Install all pip packages from PIP_PACKAGES
< PIP_PACKAGES xargs python3 -m pip install
