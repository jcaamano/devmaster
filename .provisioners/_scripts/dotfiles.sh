#!/usr/bin/env bash

repo="git@github.com:jcaamano/devmaster.git"

[ -d "${HOME}/.dotfiles" ] && {
    cd ${HOME}/.dotfiles
    git pull -f --depth 1 "$repo"
} || {
    git clone --depth 1 "$repo" ~/.dotfiles
}

cd ${HOME}/.dotfiles
stow --no-folding zsh git code-server
