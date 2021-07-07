#!/usr/bin/env bash

ID_MATCH=""
SCOPE=$1
DIR="$(dirname $0)/$SCOPE"

get_id_match() {
    [ ! -s "/etc/os-release" ] && echo "Can not find release information" && exit 1

    . /etc/os-release
    local ids=()
    ids+="$ID"
    ids+=(${ID_LIKE[@]})

    for id in $ids; do
        [ -d "${DIR}/$id" ] && ID_MATCH=$id && return
    done
}

install_packages() {
    local flavor="$1"

    [ -e "${DIR}/common/packages" ] && . ${DIR}/common/packages
    [ -n "$flavor" -a -e "${DIR}/${flavor}/packages" ] && . ${DIR}/${flavor}/packages

    [ -n "${PKG_UPGRADE}" ] && ${PKG_UPGRADE}
    [ -n "${REPOS[*]}" ] && ${REPO_INSTALL} ${REPOS[*]}
    [ -n "${PKGS[*]}" ] && ${PKG_INSTALL} ${PKGS[@]}
}

provision() {
    local flavor="$1"
    for job in $(ls -1 ${DIR}/${flavor}); do
        [ "$job" = "packages" ] && continue
	${DIR}/${flavor}/$job
    done
}

[ -z "$SCOPE" ] && echo "A scope needs to be provided" && exit 1
[ ! -d "$DIR" ] && echo "Scoped provisoner does not exist: $DIR" && exit 0

get_id_match
echo "Matched provisioner flavor: ${ID_MATCH:-none}"

install_packages "$ID_MATCH"

provision common
[ -n "$ID_MATCH" ] && provision "$ID_MATCH"

exit 0
