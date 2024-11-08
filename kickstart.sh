#!/bin/bash

# Install kickstart and its dependencies, then copy init.lua from repo

sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
cp neovim/init.lua ~/.config/nvim/init.lua
nvim
