#!/usr/bin/env bash

systemctl is-active --quiet docker || {
    sudo usermod -a -G docker $(whoami)
    sudo systemctl enable docker
    sudo systemctl start docker
}

