#!/bin/bash
# name: xplgmgr.sh
# auth: hltdev [hltdev8642@gmail.com]
# desc: X-Plane Plugin Manager Utlity
#

# import bash config parser library
. libconfig

# global variables
xplgmgr_config_root="${HOME}/.config/xplgmgr"
config="${xplgmgr_config_root}/prefs.config"

# helper to display help text
show_help ()
{
    echo "--------------------------------"
    echo "xplgmgr (x-plane plugin manager):"
    echo "--------------------------------"
    echo
    echo "Options:"
    echo "--------"
    echo -e "init\tgenerate config file"
    echo -e "help\tshow this help message"
    echo

}
# test for libconfig library
test ()
{
# If the config file exists, include it
config_test="test.conf"
cfg_exit_on_no_conf config_test
source "$config_test"

# Checks if 'level' variable is set and is a valid number
cfg_exit_on_unset level
if (( `cfg_isnum level` )); then
        plevel=$level
else
        plevel=0
fi

# Checks if 'name' variable is set
if (( `cfg_isset name` )); then
        pname=$name
else
        pname="Unknown"
fi

echo "Hi $pname!"
echo "Level: $plevel"

}


mkcfg ()
{
    cfg_exit_on_no_conf "${config}"
    source "${config}"

    # check that main config directory exists
    if [[ ! -d "${xplgmgr_config_root}" ]]; then
        echo "generating config directory"
        mkdir -p "${xplgmgr_config_root}"
        touch "${config}"
    fi

    # check that x-plane root directory is in config file
    cfg_exit_on_unset xp_root
    if (( `cfg_isnum xp_root` )); then
        xproot=$xp_root
    else
            read -p "xproot: " xpr
            xproot="$xpr"
    fi

    echo "$xproot"
}


# config utility/helper
xplgmgr_config()
{
    case "$1" in
        init)
            mkcfg
            ;;
        help)
            show_help
            ;;
        *)
            echo "\[x\] incorrect parameter \[x\]"
            ;;

    esac
}



# main program (runs w/ arguments)
main ()
{
    case "$1" in
    init)
        xplgmgr_config init
    ;;
    h|-h|help|-help|--help)
        show_help
    ;;
    *)
        show_help
    ;;
    esac

}

xplgmgr_config init

main "$@"