#!/bin/bash

xplgmgr_config_root="${HOME}/.config/xplgmgr"

# config utility/helper
xplgmgr_config()
{
    case "$1" in
        init)
            mkdir -p "${xplgmgr_config_root}"
            touch "${xplgmgr_config_root}/config"
            ;;

        *)
            echo "\[x\] incorrect parameter \[x\]"
            ;;

    esac
}



xplgmgr_config init
