#!/bin/bash
#############################################################
### Automatic setup script for Linux Debian based distros ###
#############################################################

# Clone dot files from repository
git clone https://github.com/stanislawsk/dotfiles.github
cd dotfiles
bash copy.sh
cd ../

# Install Python
bash python.sh
# Install Neovim
bash neovim.sh
# Install Fish
bash fish.sh

# Change background to black solid color
if [ -x "$(command -v gsettings)" ]; then
    gsettings set org.gnome.desktop.background picture-options none
    gsettings set org.gnome.desktop.background picture-uri ""
    gsettings set org.gnome.desktop.background primary-color '#000000'
fi

echo 'Configuration complite!'