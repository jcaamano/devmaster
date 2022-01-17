#!/bin/bash

version="$(curl -L 'https://golang.org/VERSION?m=text')"

wget "https://dl.google.com/go/${version}.linux-amd64.tar.gz"
rm -rf /usr/local/go && tar -C /usr/local -xzf ${version}.linux-amd64.tar.gz
rm -f ${version}.linux-amd64.tar.gz

mkdir -p ~/.zshrc.d/
rm -f ~/.zshrc.d/golang.zsh
echo "path=(/usr/local/go \$path)" > ~/.zshrc.d/openshift.zsh
echo "export PATH" >> ~/.zshrc.d/openshift.zsh
source ~/.zshrc.d/openshift.zsh
