#!/usr/bin/env zsh

version="$(curl -L 'https://golang.org/VERSION?m=text')"

wget "https://dl.google.com/go/${version}.linux-amd64.tar.gz"
rm -rf /usr/local/go && tar -C /usr/local -xzf ${version}.linux-amd64.tar.gz
rm -f ${version}.linux-amd64.tar.gz

CONFIG="/home/vagrant/.zshrc.d/golang.zsh"
mkdir -p $(dirname $CONFIG)
rm -f $CONFIG
echo "path=(/usr/local/go/bin \$path)" > $CONFIG
echo "export PATH" >> $CONFIG
source $CONFIG
