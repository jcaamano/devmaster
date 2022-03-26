#!/bin/bash

version="$(curl -L 'https://golang.org/VERSION?m=text')"

if [[ $EUID -eq 0 ]]; then
    wget "https://dl.google.com/go/${version}.linux-amd64.tar.gz"
    rm -rf /usr/local/go && tar -C /usr/local -xzf ${version}.linux-amd64.tar.gz
    rm -f ${version}.linux-amd64.tar.gz
else
    echo "This script must be run as root in order to install in /usr/local/go. Skipping that part." 1>&2
fi

mkdir -p ~/.zshrc.d/
rm -f ~/.zshrc.d/golang.zsh
echo "path=(/usr/local/go/bin \$path)" > ~/.zshrc.d/golang.zsh
echo "export PATH" >> ~/.zshrc.d/golang.zsh
source ~/.zshrc.d/golang.zsh
