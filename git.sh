#!/bin/bash

source '.utils/functions/git.sh'

source '.utils/functions/functions.sh'

__action="${1}"

shift

case ${__action} in

    bump)
        __bump "${1}"
        ;;
    upgrade)
        __upgrade "${1}" "$(__version_fetch "${1}")"
        ;;
    rebuild)
        __rebuild "${1}"
        ;;

esac

exit
