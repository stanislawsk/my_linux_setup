#!/bin/bash
#############################################################
### Automatic setup script for Linux Debian based distros ###
#############################################################

# Add security updates for Debian to /etc/apt/sources.list
apt_security="deb http://security.debian.org/debian-security bullseye-security main contrib non-free"
if grep -q "Debian" /etc/os-release && ! grep -q "$apt_security" /etc/apt/sources.list; then
    echo -e "\n$apt_security" >> /etc/apt/sources.list;
fi

apt update && apt -y upgrade

# Add apt repositories from file APT_REPOSITORIES to system
if ! apt show software-properties-common | grep -q "Package: software-properties-common"; then
    apt -y install software-properties-common
fi
< APT_REPOSITORIES xargs apt-add-repository -y

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
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install jethrokuan/z jorgebucaran/autopair.fish"
# ilancosman/tide@v5 PatrickF1/fzf.fish

# Change background to black solid color
if [ -x "$(command -v gsettings)" ]; then
    gsettings set org.gnome.desktop.background picture-uri ""
    gsettings set org.gnome.desktop.background primary-color '#000000'
fi

echo 'Configuration complite!'