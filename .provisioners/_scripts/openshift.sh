#!/usr/bin/env zsh

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

CONFIG="/home/vagrant/.zshrc.d/openshift.zsh"
mkdir -p $(dirname $CONFIG)
rm -f $CONFIG
echo "path=($DIR \$path)" > $CONFIG
echo "export PATH" >> $CONFIG
echo "export GOOGLE_CREDENTIALS=\${HOME}/dev/openshift/shared-secrets/gce/aos-serviceaccount.json" >> $CONFIG
echo "export AWS_PROFILE=openshift-dev" >> $CONFIG
echo "export OCP_CI_URL=https://openshift-release.apps.ci.l2s4.p1.openshiftapps.com/" >> $CONFIG
source $CONFIG

