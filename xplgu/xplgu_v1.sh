#!/bin/bash
# name: xplgu (v1.0.0)
# auth: hltdev [hltdev8642@gmail.com]
# desc:
#

# global variables
XP_HOME="/mnt/g/_XPLANE/X-Plane 11/"
XP_RES="${XP_HOME}/Resources/"
XP_PLG_E="${XP_HOME}/Resources/plugins"
XP_PLG_D="${XP_HOME}/Resources/plugins (disabled)"
XPLGU_HOME="${HOME}/.config/xplgu"

# create config directory (if does not exist yet)
mkdir -p "$XPLGU_HOME"


# create config lists in conf dir (enabled/disabled)
touch "${XPLGU_HOME}/enabled.conf"
touch "${XPLGU_HOME}/disabled.conf"

# set list of enabled plugins
set_enabled_list ()
{
    enabled_list=$(fdfind . "$XP_PLG_E" -t d -d 1)
    echo "${enabled_list}" > "${XPLGU_HOME}/enabled.conf"

}

# set list of disabled plugins
set_disabled_list ()
{
    disabled_list=$(fdfind . "$XP_PLG_D" -t d -d 1)
    echo "${disabled_list}" > "${XPLGU_HOME}/disabled.conf"

}

# get list of enabled plugins
get_enabled ()
{
    cat "${XPLGU_HOME}/enabled.conf" | awk  -F '/' '{print $NF}'
}

# get list of disabled plugins
get_disabled ()
{
    cat "${XPLGU_HOME}/disabled.conf" | awk  -F '/' '{print $NF}'
}


# enable a plugin
set_enabled ()
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
set_disabled ()
{

    if [[ -z $1 ]]; then
        echo "error: [no input]"
    else
        mv "${XP_PLG_E}/${1}" "${XP_PLG_D}" -i
    fi
    set_enabled_list
    set_disabled_list
}

# install a plugin
install_plugin ()
{
    if [[ -z $1 ]]; then
        echo "location of plugin zip file:"
        read zip_input
    else
        zip_input="$1"
    fi

    unzip "$zip_input" -d "$XP_PLG_E"
}


# help function (todo)
show_help ()
{
    echo "help (TODO)"
}
# IN PROGRESS [DANGER: DO NOT USE YET]
# delete a plugin
# delete_plugin ()
# {
# if [[ -z $1 ]]; then
#   get_enabled
#   get_disabled
#   echo "name of plugin to delete:"
#   read plg_del
# else
#   plg_del="$1"
# fi
#
# }

# set list of enabled plugins
# echo "setting enabled list . . ."
# set_enabled_list
# set list of disabled plugins
# echo "setting disabled list . . ."
# set_disabled_list

case $1 in
    set)
        case $2 in
            enabled)
                set_enabled "${@:3}"
            ;;
            disabled)
                set_disabled "${@:3}"
            ;;
            *)
                show_help
            ;;
        esac
    ;;

    get)
        case $2 in
            enabled)
                get_enabled "${@:3}"
            ;;
            disabled)
                get_disabled "${@:3}"
            ;;
            *)
                show_help
            ;;
        esac
    ;;

    list)
        case $2 in
            enabled)
               set_enabled_list
            ;;
            disabled)
               set_disabled_list
            ;;
            *)
                show_help
            ;;
        esac
    ;;
    *)
        show_help
    ;;
esac


# main "$@"
