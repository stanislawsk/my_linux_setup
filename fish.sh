#!/bin/bash
########################################
### Install Fish and Fisher plugins  ###
########################################

PLUGINS="jethrokuan/z jorgebucaran/autopair.fish IlanCosman/tide@v5"

apt-add-repository -y ppa:fish-shell/release-3
apt update
apt -y install fish curl

# Set fish as default shell
chsh -s $(which fish)

# Download Nerd fonts
if ! [ -f 3270.zip ]; then
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/3270.zip
fi
# Install Nerd fonts
if [ -f 3270.zip ]; then
    pwd=$(pwd)
    runuser -l $SUDO_USER -c "unzip $pwd/3270.zip -d ~/.fonts"
    rm 3270.zip
fi

# Install fisher
runuser -l $SUDO_USER -c "fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'"
# Install fisher plugins
runuser -l $SUDO_USER -c "fish -c 'fisher install $PLUGINS'"