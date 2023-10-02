#!/usr/bin/env bash

set -x

#from https://raw.githubusercontent.com/cdr/code-server/main/install.sh
echo_latest_version() {
  # https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c#gistcomment-2758860
  version="$(curl -fsSLI -o /dev/null -w "%{url_effective}" https://github.com/cdr/code-server/releases/latest)"
  version="${version#*/releases/tag/}"
  version="${version#v}"
  echo "$version"
}

arch() {
  case "$(uname -m)" in
    aarch64)
      echo arm64
      ;;
    x86_64)
      echo amd64
      ;;
    amd64) # FreeBSD.
      echo amd64
      ;;
  esac
}

ARCH="$(arch)"
VERSION="$(echo_latest_version)"
RPM="code-server-$VERSION-$ARCH.rpm"
URL="https://github.com/cdr/code-server/releases/download/v$VERSION/$RPM"

curl -fL --no-progress-meter -o "$RPM" "$URL"
sudo rpm -iU "$RPM"
rm "$RPM"

sudo systemctl enable code-server@vagrant
sudo systemctl restart code-server@vagrant
