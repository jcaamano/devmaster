#!/usr/bin/env bash

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

version=$(get_latest_release "cli/cli")
version="${version#v}"
rpm -i https://github.com/cli/cli/releases/download/v${version}/gh_${version}_linux_amd64.rpm
