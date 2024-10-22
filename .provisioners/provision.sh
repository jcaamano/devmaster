#!/usr/bin/env bash

ID_MATCH=""
SCOPE=$1
DIR="$(dirname $0)/$SCOPE"

run() {
	echo "Running provisioner command: $@"
	$@
}

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

    [ -n "${PKG_CLEAN}" ] && run ${PKG_CLEAN}
    [ -n "${PKG_UPGRADE}" ] && run ${PKG_UPGRADE}
    for repo in "${REPOS[@]}"; do
        run ${REPO_INSTALL} "$repo"
    done
    [ -n "${PKGS[*]}" ] && run ${PKG_INSTALL} ${PKGS[@]}
}

install_pips() {
    [ -e "${DIR}/common/pips" ] && . ${DIR}/common/pips
    PIP_INSTALL="pip install --user "
    if [ "$SCOPE" = "system" ]; then
        PIP_INSTALL="pip install "
    elif [ "$SCOPE" != "user" ]; then
        return
    fi
    [ -n "${PIPS[*]}" ] && run ${PIP_INSTALL} ${PIPS[@]}
}

install_sysctl() {
    local flavor="$1"
    [ -f "${DIR}/common/sysctl" ] && {
        sysctl -p "${DIR}/common/sysctl"
        cp "${DIR}/common/sysctl" "/etc/sysctl.d/99-provision-common.conf"
    }
    [ -f "${DIR}/${flavor}/sysctl" ] && {
        sysctl -p "${DIR}/${flavor}/sysctl"
        cp "${DIR}/${flavor}/sysctl" "/etc/sysctl.d/99-provision-${flavor}.conf"
    }
}

provision() {
    local flavor="$1"
    for job in $(ls -1 ${DIR}/${flavor}); do
        [[ "$job" =~ ^(packages|pips|sysctl)$ ]] && continue
	run ${DIR}/${flavor}/$job
    done
}

[ -z "$SCOPE" ] && echo "A scope needs to be provided" && exit 1
[ ! -d "$DIR" ] && echo "Scoped provisoner does not exist: $DIR" && exit 0

get_id_match
echo "Matched provisioner flavor: ${ID_MATCH:-none}"

install_sysctl "$ID_MATCH"
install_packages "$ID_MATCH"
install_pips

provision common
[ -n "$ID_MATCH" ] && provision "$ID_MATCH"

exit 0
