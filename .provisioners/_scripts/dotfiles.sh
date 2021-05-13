#!/usr/bin/env bash

[ -d "${HOME}/.dotfiles" ] && {
    cd ${HOME}/.dotfiles
    git pull -f --depth 1 https://github.com/jcaamano/dotfiles.git
} || {
    git clone --depth 1 https://github.com/jcaamano/dotfiles.git ~/.dotfiles
}

cd ${HOME}/.dotfiles
stow --no-folding zsh git code-server
