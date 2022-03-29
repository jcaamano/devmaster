#!/usr/bin/env zsh

VERSION=${1:-latest}
URL="${URL:-https://mirror.openshift.com/pub/openshift-v4/clients/ocp}"
DIR="/home/$USER/src/openshift/installer/${VERSION}"

mkdir -p /home/$USER/src/openshift/installer/${VERSION}
mkdir -p "$DIR" && cd "$DIR"
wget "${URL}/${VERSION}/openshift-client-linux-${VERSION}.tar.gz" && tar -xzvf openshift-client-linux-${VERSION}.tar.gz
wget "${URL}/${VERSION}/openshift-install-linux-${VERSION}.tar.gz" && tar -xzvf openshift-install-linux-${VERSION}.tar.gz
rm openshift-install-linux-${VERSION}.tar.gz openshift-client-linux-${VERSION}.tar.gz

CONFIG="/home/vagrant/.zshrc.d/openshift.zsh"
mkdir -p $(dirname $CONFIG)
rm -f $CONFIG
echo "path=($DIR \$path)" > $CONFIG
echo "export PATH" >> $CONFIG
echo "export GOOGLE_CREDENTIALS=\${HOME}/dev/openshift/shared-secrets/gce/aos-serviceaccount.json" >> $CONFIG
source $CONFIG

