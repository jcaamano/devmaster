#!/usr/bin/env bash

set -x

curl -sL --no-progress-meter https://github.com/gmeghnag/omc/releases/latest/download/omc_Linux_x86_64.tar.gz | tar --directory /usr/local/bin/ -xzvf - omc
chmod +x /usr/local/bin/omc
