#!/usr/bin/env zsh

set -x

# install go
version="$(curl -sL 'https://golang.org/VERSION?m=text' | head -1)"

wget -nv "https://go.dev/dl/${version}.linux-amd64.tar.gz"
rm -rf /usr/local/go && tar -C /usr/local -xzf ${version}.linux-amd64.tar.gz
rm -f ${version}.linux-amd64.tar.gz

CONFIG="/home/vagrant/.zshrc.d/golang.zsh"
mkdir -p $(dirname $CONFIG)
rm -f $CONFIG
echo "path=(/home/vagrant/go/bin /usr/local/go/bin \$path)" > $CONFIG
echo "export PATH" >> $CONFIG
chown -R vagrant:vagrant $(dirname $CONFIG)
source $CONFIG
