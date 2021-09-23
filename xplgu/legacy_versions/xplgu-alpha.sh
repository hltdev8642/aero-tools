#!/bin/bash
# name: xplgu (v0.1.0) (alpha)
# auth: hltdev [hltdev8642@gmail.com]
# desc:
#

# global variables
XP_PLG_E="${XP_HOME}/Resources/plugins"
XP_PLG_D="${XP_HOME}/Resources/plugins (disabled)"
XPLGU_HOME="${HOME}/.config/xplgu"

# create config directory (if does not exist yet)
mkdir -p "$XPLGU_HOME"

touch "${XPLGU_HOME}/xp_home.conf"

check_home="$(cat ${XPLGU_HOME}/xp_home.conf)"
if [[ -z $check_home ]]; then
    echo "X-Plane Root Path: "
    read XP_HOME
    echo "\'$XP_HOME\'" > "${XPLGU_HOME}/xp_home.conf"
else
    XP_HOME=$"(cat ${XP_HOME}/xp_home.conf)"
fi


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

    mv "${XP_PLG_D}/${1}" "${XP_PLG_E}" -i
    set_enabled_list
    set_disabled_list
}

# disable a plugin
set_disabled ()
{
    mv "${XP_PLG_E}/${1}" "${XP_PLG_D}" -i
    set_enabled_list
    set_disabled_list
}


# set list of enabled plugins
echo "setting enabled list . . ."
set_enabled_list
# set list of disabled plugins
echo "setting disabled list . . ."
set_disabled_list


# main "$@"