#!/usr/bin/env bash

# prompt, uses sudo to install
curl -sS https://starship.rs/install.sh | sh -s -- -y
FISH_CONFIG=$HOME/.config/fish/conf.d/starship.fish
rm -f $FISH_CONFIG
echo "starship init fish | source" > $FISH_CONFIG 

# set shell
sudo chsh -s $(which fish) $USER
