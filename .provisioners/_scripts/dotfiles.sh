#!/usr/bin/env bash

repo="jcaamano/dotfiles.git"
repo_https="https://github.com/$repo"
repo_git="git@github.com:$repo"

[ -d "${HOME}/.dotfiles" ] && {
    cd ${HOME}/.dotfiles
    git pull -f --depth 1 "$repo_https"
} || {
    git clone --depth 1 "$repo_https" ~/.dotfiles
    git remote add upstream "$repo_git"
}

cd ${HOME}/.dotfiles
stow zsh git code-server
