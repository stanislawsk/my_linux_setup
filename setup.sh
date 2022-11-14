#!/bin/bash

# Add security updates for Debian to /etc/apt/sources.list
apt_security="deb http://security.debian.org/debian-security bullseye-security main contrib non-free"
if grep -q "Debian" /etc/os-release && ! grep -q "$apt_security" /etc/apt/sources.list; then
    echo -e "\n$apt_security" >> /etc/apt/sources.list;
fi
# Add apt repositories from file APT_REPOSITORIES to system
if ! apt show software-properties-common | grep -q "Package: software-properties-common"; then
    apt -y install software-properties-common
fi
< APT_REPOSITORIES xargs apt-add-repository -y

apt update && apt -y upgrade

# Install all apt packages from APT_PACKAGES file
< APT_PACKAGES xargs apt -y install

# Install Python
bash python.sh
# Install Neovim
bash neovim.sh

# copy configs
cp -fr .config ~
cp -fr .moc ~
chmod 755 ~/.moc/config

# Set fish as default shell
chsh -s $(which fish)
# Install fisher and fisher plugins
< FISH_PLUGINS xargs curl -sL https://git.io/fisher | source && fisher install 

fish