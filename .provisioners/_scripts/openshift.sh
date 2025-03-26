#!/usr/bin/env bash 

set -x

VERSION=${1:-}
URL="${URL:-https://mirror.openshift.com/pub/openshift-v4/clients/ocp}"
DIR="/home/$USER/src/openshift/installer/${VERSION}"

VERSIOND=${VERSION:-latest}
VERSIONF=${VERSION:+-$VERSION}

mkdir -p /home/$USER/src/openshift/installer/${VERSIOND}
mkdir -p "$DIR" && cd "$DIR"
rm -f openshift-install-linux${VERSIONF}.tar.gz openshift-client-linux${VERSIONF}.tar.gz
wget -nv "${URL}/${VERSIOND}/openshift-client-linux${VERSIONF}.tar.gz" && tar -xzvf openshift-client-linux${VERSIONF}.tar.gz
wget -nv "${URL}/${VERSIOND}/openshift-install-linux${VERSIONF}.tar.gz" && tar -xzvf openshift-install-linux${VERSIONF}.tar.gz
rm -f openshift-install-linux${VERSIONF}.tar.gz openshift-client-linux${VERSIONF}.tar.gz

ZSH_CONFIG="/home/vagrant/.zshrc.d/openshift.zsh"
if command -v zsh 2>&1 >/dev/null; then
  mkdir -p "${ZSH_CONFIG%/*}"
  rm -f $ZSH_CONFIG
  echo "path=($DIR \$path)" > $ZSH_CONFIG
  echo "export PATH" >> $ZSH_CONFIG
  echo "export GOOGLE_CREDENTIALS=\${HOME}/dev/openshift/shared-secrets/gce/aos-serviceaccount.json" >> $ZSH_CONFIG
  echo "export AWS_PROFILE=openshift-dev" >> $CONFIG
  echo "export OCP_CI_URL=https://openshift-release.apps.ci.l2s4.p1.openshiftapps.com/" >> $ZSH_CONFIG
fi

FISH_CONFIG="/home/vagrant/.config/fish/conf.d/openshift.fish"
if command -v fish 2>&1 >/dev/null; then
  mkdir -p "${FISH_CONFIG%/*}"
  rm -f $FISH_CONFIG
  echo "fish_add_path --path $DIR" > $FISH_CONFIG
  echo "set -x GOOGLE_CREDENTIALS {\$HOME}/dev/openshift/shared-secrets/gce/aos-serviceaccount.json" >> $FISH_CONFIG
  echo "set -x AWS_PROFILE openshift-dev" >> $FISH_CONFIG
  echo "set -x OCP_CI_URL https://openshift-release.apps.ci.l2s4.p1.openshiftapps.com/" >> $FISH_CONFIG
fi

