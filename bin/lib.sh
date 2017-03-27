#!/usr/bin/env bash
_src="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"
source ${_src}/../lib/b-log.sh

function init_logging {
    LOG_LEVEL_ALL
    B_LOG --file $(config "log.file") --file-prefix-enable --file-suffix-enable
    [[ $(config "log.syslog.enabled") ]] && B_LOG --syslog "--tag $(config 'log.tag')"
}

function config {
    val=$(grep -E "^${1}=" $(config_file) 2>/dev/null || echo "${1}=__DEFAULT__" | head -n 1 | cut -d '=' -f 2-)
    [[ ${val} == __DEFAULT__ ]] && printf "$(default ${key})" || printf "${val}"
}

function config_file() {
    [[ -f ${CONFIG_FILE} ]] && printf "${CONFIG_FILE}" && return
    _src="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"
    [[ -f "${_src}/conf/music.conf" ]] && printf "${_src}/music.conf" && return
    printf "/dev/null" && return
}

function default {
    f="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)/default.conf"
    val=$(grep -E "^${1}=" ${f} 2>/dev/null | head -n 1 | cut -d '=' -f 2-)
    printf "${val}"
}

init_logging
