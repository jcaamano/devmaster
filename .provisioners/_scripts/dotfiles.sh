#!/usr/bin/env bash

repo="jcaamano/dotfiles.git"
repo_https="https://github.com/$repo"
repo_git="git@github.com:$repo"

[ -d "${HOME}/.dotfiles" ] && {
    cd ${HOME}/.dotfiles
    git pull -f --depth 1 "$repo_https"
} || {
    git clone --depth 1 "$repo_https" ${HOME}/.dotfiles
    cd ${HOME}/.dotfiles
    git remote add upstream "$repo_git"
}

stow git code-server devbin

if command -v zsh 2>&1 >/dev/null; then
  stow zsh
fi

if command -v fish 2>&1 >/dev/null; then
  stow fish
fi
