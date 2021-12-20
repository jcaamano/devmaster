#!/usr/bin/env bash

VERSION=${1:-latest}
URL="https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${VERSION}"
DIR="/home/$USER/src/openshift/installer/${VERSION}"

mkdir -p /home/$USER/src/openshift/installer/${VERSION}
mkdir -p "$DIR" && cd "$DIR"
wget "${URL}/openshift-client-linux.tar.gz" && tar -xzvf openshift-client-linux.tar.gz
wget "${URL}/openshift-install-linux.tar.gz" && tar -xzvf openshift-install-linux.tar.gz
rm openshift-install-linux.tar.gz openshift-client-linux.tar.gz

mkdir -p ~/.zshrc.d/
touch ~/.zshrc.d/openshift.zsh
echo "export PATH=\$PATH:$DIR" >> ~/.zshrc.d/openshift.zsh
echo "export GOOGLE_CREDENTIALS=\${HOME}/dev/openshift/shared-secrets/gce/aos-serviceaccount.json" >> ~/.zshrc.d/openshift.zsh
source ~/.zshrc.d/openshift.zsh

