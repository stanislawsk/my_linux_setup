#!/bin/bash
#########################################################
### Install Neovim and AstroNvim with your own config ###
#########################################################

# Name of public github repository with AstroNvim configuration
CONFIG_REPO="stanislawsk/astronvim_config"

# Install wget if not installed
if ! wget --version | grep -q "GNU Wget"; then
    apt -y install wget
fi
# Install git if not installed
if ! git --version | grep -q "git version"; then
    apt -y install git
fi

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
git clone https://github.com/AstroNvim/AstroNvim /home/$SUDO_USER/.config/nvim
git clone https://github.com/$CONFIG_REPO.git /home/$SUDO_USER/.config/nvim/lua/user
git clone https://github.com/AstroNvim/AstroNvim /root/.config/nvim
git clone https://github.com/$CONFIG_REPO.git /root/.config/nvim/lua/user
runuser -l $SUDO_USER -c "nvim  --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'"
