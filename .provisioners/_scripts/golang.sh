#!/usr/bin/env bash

set -x

# install go
version="$(curl -sL 'https://golang.org/VERSION?m=text' | head -1)"

wget -nv "https://go.dev/dl/${version}.linux-amd64.tar.gz"
rm -rf /usr/local/go && tar -C /usr/local -xzf ${version}.linux-amd64.tar.gz
rm -f ${version}.linux-amd64.tar.gz


function config() {
  ZSH_CONFIG="/home/$USER/.zshrc.d/golang.zsh"
  if command -v zsh 2>&1 >/dev/null; then
    mkdir -p "${ZSH_CONFIG%/*}"
    rm -f $ZSH_CONFIG
    echo "path=(/home/$USER/go/bin /usr/local/go/bin \$path)" > $ZSH_CONFIG
    echo "export PATH" >> $ZSH_CONFIG
  fi
  
  FISH_CONFIG="/home/$USER/.config/fish/conf.d/golang.fish"
  if command -v fish 2>&1 >/dev/null; then
    mkdir -p "${FISH_CONFIG%/*}"
    rm -f $FISH_CONFIG
    echo "fish_add_path --path /home/$USER/go/bin /usr/local/go/bin" > $FISH_CONFIG
  fi
}

sudo -u vagrant bash -c "$(declare -f config); config"
