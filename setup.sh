#!/bin/bash

# Add security updates for Debian to /etc/apt/sources.list
apt_security="deb http://security.debian.org/debian-security bullseye-security main contrib non-free"
if grep -q "Debian" /etc/os-release && ! grep -q "$apt_security" /etc/apt/sources.list; then
    echo -e "\n$apt_security" >> /etc/apt/sources.list;
fi

# Install all apt package from APT_LIST file
apt update
< APT_LIST xargs apt -y install

# Instal Neovim
bash neovim.sh
