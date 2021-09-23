#!/bin/bash
# name: X-Plane-Utility.sh [v0.1]
# auth: hltdev [hltdev8642@gmail.com]
# desc: X-Plane Resource Manager CLI/Script (XPRM)
#

xprm_config_root="${HOME}/.config/xprm"

# config utility/helper
xprm_config()
{
    case "$1" in
    init)
        mkdir -p "${xprm_config_root}"
        touch "${xprm_config_root}/config"
        ;;

    *)
        echo "\[x\] incorrect parameter \[x\]"
        ;;

    esac
}

# list all aircraft (.acf files) in current directory recursively
list_aircraft()
{
    fdfind -e acf -uH | awk -F '/' '{print $NF}' "${@:1}"
    # | xargs -d '\n'
}

#
# acf property helper
# will help to add missing labels/identifiers into acf files (exanokes: version, author, etc)
#

#
# IN PROGRESS
#

# generate_acf_labels ()
# {

# ICAO="0"
# author="0"
# average_mac_acf="0"
# callsign="0"
# descrip="0"
# manufacturer="0"
# name="0"
# notes="0"
# studio="0"
# tailnum="0"
# version="0"

# }

# # # helper to read properties
# read_property ()
# {
#     if [[ $1 != "0" ]]; then
#             echo
#     fi
# }

#
# TO DO: Aircraft thumbnail generator helper function (generate_acf_thumbnail)
#

# P acf/_ICAO
# P acf/_author
# P acf/_average_mac_acf -
# P acf/_callsign
# P acf/_descrip
# P acf/_manufacturer
# P acf/_name
# P acf/_notes
# P acf/_studio
# P acf/_tailnum
# P acf/_version

# `tests write_acf_prop` function
test_write_acf_props()
{

    echo "ICAO:"
    read ICAO

    echo "author:"
    read author

    echo "average_mac_acf:"
    read average_mac_acf

    echo "callsign:"
    read callsign

    echo "descrip:"
    read descrip

    echo "manufacturer:"
    read manufacturer

    echo "name:"
    read name

    echo "notes:"
    read notes

    echo "studio:"
    read studio

    echo "tailnum:"
    read tailnum

    echo "version:"
    read version

    echo "P acf/_ICAO $ICAO"
    echo "P acf/_author $author"
    echo "P acf/_average_mac_acf $average_mac_acf"
    echo "P acf/_callsign $callsign"
    echo "P acf/_descrip $descrip"
    echo "P acf/_manufacturer $manufacturer"
    echo "P acf/_name $name"
    echo "P acf/_notes $notes"
    echo "P acf/_studio $studio"
    echo "P acf/_tailnum $tailnum"
    echo "P acf/_version $version"

}

write_acf_prop()
{

    case $1 in
    "ICAO")
        gen_prop_ICAO "${@:2}"
        ;;
    "author")
        gen_prop_author "${@:2}"
        ;;
    "average_mac_acf")
        gen_prop_average_mac_acf "${@:2}"
        ;;
    "callsign")
        gen_prop_callsign "${@:2}"
        ;;
    "descrip")
        gen_prop_descrip "${@:2}"
        ;;
    "manufacturer")
        gen_prop_manufacturer "${@:2}"
        ;;
    "name")
        gen_prop_name "${@:2}"
        ;;
    "notes")
        gen_prop_notes "${@:2}"
        ;;
    "studio")
        gen_prop_studio "${@:2}"
        ;;
    "tailnum")
        gen_prop_tailnum "${@:2}"
        ;;
    "version")
        gen_prop_version "${@:2}"
        ;;

    *)
        echo "Property Invalid / Unavailable"
        ;;

    esac
}

gen_prop_ICAO()
{
    echo "P acf/_ICAO ${1}"
}
gen_prop_author()
{
    echo "P acf/_author ${1}"
}
gen_prop_average_mac_acf()
{
    echo "P acf/_average_mac_acf  ${1}"
}
gen_prop_callsign()
{
    echo "P acf/_callsign ${1}"
}
gen_prop_descrip()
{
    echo "P acf/_descrip ${1}"
}
gen_prop_manufacturer()
{
    echo "P acf/_manufacturer ${1}"
}
gen_prop_name()
{
    echo "P acf/_name ${1}"
}
gen_prop_notes()
{
    echo "P acf/_notes ${1}"
}
gen_prop_studio()
{
    echo "P acf/_studio ${1}"
}
gen_prop_tailnum()
{
    echo "P acf/_tailnum ${1}"
}
gen_prop_version()
{
    echo "P acf/_version ${1}"
}

# displays help text/data output
show_help()
{
    echo -e "X-Plane Resource Manager CLI/Script (XPRM) \
            \nhelp\tshow this help message. \
    \nlist\tlist aircraft"
}

# main entrypoint for program
xprm()
{
    case $1 in
    h | -h | help | -help | --help | ? | -?)
        show_help
        ;;
    -l | l | --ls | ls | --list | list | list_aircraft | ls-acf | acf | aircraft | planes | ls-planes | ls-aircraft)
        list_aircraft "${@:2}"
        ;;
    -r | r | read | --read)
        write_acf_prop "${@:2}"
        ;;
    -t | t | test | --test)
        test_write_acf_props

        ;;
    *)
        show_help
        ;;
    esac
}

# config initialization / creation (if not yet existing)
xprm_config init

# start program (w/ args)
xprm "$@"
