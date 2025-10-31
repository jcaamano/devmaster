#!/usr/bin/env bash

set -e

repo="jcaamano/dotfiles.git"
repo_https="https://github.com/$repo"
repo_git="git@github.com:$repo"

[ -d "${HOME}/.dotfiles" ] && {
    cd ${HOME}/.dotfiles
    git pull --rebase --depth 1 "$repo_https"
} || {
    git clone --depth 1 "$repo_https" ${HOME}/.dotfiles
    cd ${HOME}/.dotfiles
    git remote add upstream "$repo_git"
}

DOTS+=(git code-server devbin claude)

stow git code-server devbin claude

if command -v zsh 2>&1 >/dev/null; then
  DOTS+=(zsh)
  stow zsh
fi

if command -v fish 2>&1 >/dev/null; then
  stow fish
  DOTS+=(fish)
fi

stow ${DOTS[@]}

cat << EOF > $HOME/.local/bin/check_dotfiles.sh
#!/bin/bash

[ -d "$HOME/.dotfiles" ] || exit

cd $HOME/.dotfiles
for dot in ${DOTS[@]}; do
  git diff --quiet \$dot && git diff --cached --quiet \$dot && [ -z "\$(git clean -n \$dot)" ] && continue
  echo "Configuration for \$dot changed"
  exit 1
done

EOF

chmod a+x $HOME/.local/bin/check_dotfiles.sh

