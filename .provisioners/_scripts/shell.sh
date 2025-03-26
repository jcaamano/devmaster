#!/usr/bin/env bash

# prompt
curl -sS https://starship.rs/install.sh | sh -s -- -y
FISH_CONFIG=$HOME/.config/fish/conf.d/starship.fish
rm -f $FISH_CONFIG
echo "starship init fish | source" > $FISH_CONFIG 

# remove greeting
FISH_CONFIG=$HOME/.config/fish/conf.d/nogreeting.fish
rm -f $FISH_CONFIG
echo "set -g fish_greeting" > $FISH_CONFIG

# permissions
chown -R vagrant:vagrant ${FISH_CONFIG%/*}

# set shell
chsh -s $(which fish) vagrant
