#!/bin/bash
#########################################################
### Install Neovim and AstroNvim with your own config ###
#########################################################

# Name of public github repository with AstroNvim configuration
CONFIG_REPO="stanislawsk/astronvim_config"

# Intall Neovim v0.8.0 if not installed
if ! nvim -v | grep -q "NVIM v0.8.0"; then
    if ! [ -f nvim-linux64.deb ]; then
        wget https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.deb
    fi

    if sha256sum -c sum/nvim-linux64.deb.sha256sum; then
        apt -y install ./nvim-linux64.deb
    fi
fi

# Remove nvim-linux64.deb file
if [ -f nvim-linux64.deb ]; then
    rm nvim-linux64.deb
fi

# Remove Nvim configuration
if [ -d /home/$SUDO_USER/.config/nvim ]; then
    rm -r /home/$SUDO_USER/.config/nvim
    rm -r /root/.config/nvim
fi

# Install AstroNvim and my own configuration from CONFIG_REPO
git clone https://github.com/AstroNvim/AstroNvim /root/.config/nvim
git clone https://github.com/$CONFIG_REPO.git /root/.config/nvim/lua/user
cp -r /root/.config/nvim ~/.config/nvim
runuser -l $SUDO_USER -c "nvim  --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'"
