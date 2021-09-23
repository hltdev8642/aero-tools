#!/bin/bash
# name: xplgu (v2.0.0)
# auth: hltdev [hltdev8642@gmail.com]
# desc:
#

# global variables
XP_HOME="/mnt/g/_XPLANE/X-Plane 11/"
XP_RES="${XP_HOME}/Resources/"
XPLGU_HOME="${HOME}/.config/xplgu"

# create config directory (if does not exist yet)
mkdir -p "$XPLGU_HOME"


XP_PLG_E="${XP_HOME}/Resources/plugins"
XP_PLG_D="${XP_HOME}/Resources/plugins (disabled)"

# create config lists in conf dir (enabled/disabled)
touch "${XPLGU_HOME}/plg_enabled.conf"
touch "${XPLGU_HOME}/plg_disabled.conf"


XP_PLG_FWL_E="${XP_HOME}/Resources/plugins/FlyWithLua/Scripts"
XP_PLG_FWL_D="${XP_HOME}/Resources/plugins/FlyWithLua/Scripts (disabled)"


# create config lists in conf dir (enabled/disabled)
touch "${XPLGU_HOME}/fwl_enabled.conf"
touch "${XPLGU_HOME}/fwl_disabled.conf"


###############################################################################
# stdplugins ##################################################################
###############################################################################

# set list of enabled plugins
set_enabled_list()
{
    enabled_list=$(fdfind . "$XP_PLG_E" -t d -d 1)
    echo "${enabled_list}" >"${XPLGU_HOME}/plg_enabled.conf"

}

# set list of disabled plugins
set_disabled_list()
{
    disabled_list=$(fdfind . "$XP_PLG_D" -t d -d 1)
    echo "${disabled_list}" >"${XPLGU_HOME}/plg_disabled.conf"

}

# get list of enabled plugins
get_enabled()
{
    cat "${XPLGU_HOME}/plg_enabled.conf" | awk -F '/' '{print $NF}'
}

# get list of disabled plugins
get_disabled()
{
    cat "${XPLGU_HOME}/plg_disabled.conf" | awk -F '/' '{print $NF}'
}

# enable a plugin
set_enabled()
{
    if [[ -z $1 ]]; then
        echo "error: [no input]"
    else
        mv "${XP_PLG_D}/${1}" "${XP_PLG_E}" -i
    fi

    set_enabled_list
    set_disabled_list
}

# disable a plugin
set_disabled()
{

    if [[ -z $1 ]]; then
        echo "error: [no input]"
    else
        mv "${XP_PLG_E}/${1}" "${XP_PLG_D}" -i
    fi
    set_enabled_list
    set_disabled_list
}

###############################################################################
# flywithlua ##################################################################
###############################################################################



# set list of enabled plugins
fwl_set_enabled_list()
{
    enabled_list=$(fdfind . "$XP_PLG_FWL_E" -d 2)
    echo "${enabled_list}" >"${XPLGU_HOME}/fwl_enabled.conf"

}

# set list of disabled plugins
fwl_set_disabled_list()
{
    disabled_list=$(fdfind . "$XP_PLG_FWL_D" -d 2)
    echo "${disabled_list}" >"${XPLGU_HOME}/fwl_disabled.conf"

}

# get list of enabled plugins
fwl_get_enabled()
{
    cat "${XPLGU_HOME}/fwl_enabled.conf" | awk -F '/' '{print $NF}'
}

# get list of disabled plugins
fwl_get_disabled()
{
    cat "${XPLGU_HOME}/fwl_disabled.conf" | awk -F '/' '{print $NF}'
}

# enable a plugin
fwl_set_enabled()
{
    if [[ -z $1 ]]; then
        echo "error: [no input]"
    else
        mv "${XP_PLG_FWL_D}/${1}" "${XP_PLG_FWL_E}" -i
    fi

    fwl_set_enabled_list
    fwl_set_disabled_list
}

# disable a plugin
fwl_set_disabled()
{

    if [[ -z $1 ]]; then
        echo "error: [no input]"
    else
        mv "${XP_PLG_FWL_E}/${1}" "${XP_PLG_FWL_D}" -i
    fi
    fwl_set_enabled_list
    fwl_set_disabled_list
}



# install a plugin
install_plugin()
{
    if [[ -z $1 ]]; then
        echo "location of script zip file:"
        read zip_input
    else
        zip_input="$1"
    fi

    unzip "$zip_input" -d "$XP_PLG_FWL_E"
}

# help function (todo)
show_help()
{
    echo "help (TODO)"
}



case $1 in
    f|fwl|flywithlua|scripts)
        case $2 in
            set )
                case $3 in
                    enabled )
                        fwl_set_enabled "${@:4}"
                    ;;
                    disabled )
                        fwl_set_disabled "${@:4}"
                    ;;
                    *)
                        show_help
                    ;;
                esac
            ;;
            get )
                case $3 in
                    enabled )
                        fwl_get_enabled "${@:4}"
                    ;;
                    disabled )
                        fwl_get_disabled "${@:4}"
                    ;;
                    *)
                        show_help
                    ;;
                esac
            ;;
            list )
                case $3 in
                    enabled )
                        fwl_set_enabled_list
                    ;;
                    disabled )
                        fwl_set_disabled_list
                    ;;
                    * )
                        show_help
                    ;;
                esac
            ;;
            * )
                show_help
            ;;
        esac
    ;;
    p|plg|plugin|plugins)
        case $2 in
            set )
                case $3 in
                    enabled )
                        set_enabled "${@:4}"
                    ;;
                    disabled )
                        set_disabled "${@:4}"
                    ;;
                    *)
                        show_help
                    ;;
                esac
            ;;
            get )
                case $3 in
                    enabled )
                        get_enabled "${@:4}"
                    ;;
                    disabled )
                        get_disabled "${@:4}"
                    ;;
                    *)
                        show_help
                    ;;
                esac
            ;;
            list )
                case $3 in
                    enabled )
                        set_enabled_list
                    ;;
                    disabled )
                        set_disabled_list
                    ;;
                    * )
                        show_help
                    ;;
                esac
            ;;
            * )
                show_help
            ;;
        esac
    ;;
    *)
        case $1 in
            set )
                case $2 in
                    enabled )
                        set_enabled "${@:3}"
                    ;;
                    disabled )
                        set_disabled "${@:3}"
                    ;;
                    *)
                        show_help
                    ;;
                esac
            ;;
            get )
                case $2 in
                    enabled )
                        get_enabled "${@:3}"
                    ;;
                    disabled )
                        get_disabled "${@:3}"
                    ;;
                    *)
                        show_help
                    ;;
                esac
            ;;
            list )
                case $2 in
                    enabled )
                        set_enabled_list
                    ;;
                    disabled )
                        set_disabled_list
                    ;;
                    * )
                        show_help
                    ;;
                esac
            ;;
            * )
                show_help
            ;;
        esac
    ;;
esac
