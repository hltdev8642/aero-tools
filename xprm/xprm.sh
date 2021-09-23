#!/bin/bash
# name: X-Plane-Utility.sh [v1.0.0]
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
    fdfind -e acf -uH --threads=100 | awk -F '/' '{print $NF}' "${@:1}"
    # | xargs -d '\n'
}


tolowercase () {
    cat "${@:1}" | tr '[:upper:]' '[:lower:]'
}

#
# get a single property from an acf file
# format of search =>  `P acf/_xyz`
# usage: `get_acf_prop [filename.acf] [query]`
#

get_acf_prop ()
{
    acf_file="$1"
    property=$(echo "_$2" | tolowercase - )
    grep -w "${property}" "${acf_file}"   | awk -F "${property}" '{print $NF}'

}

#
# get all acf properties from an acf file
# format of search =>  `P acf/_xyz`
# usage: `get_acf_prop_all [filename.acf]`
#
get_acf_prop_all ()
{
    acf_file="$1"
    grep "acf/_" -P "${acf_file}"   | awk -F 'P acf/_' '{print $NF}'
    # grep "acf/_"  -P 747-400.acf
}



#
# search for a single property in an acf file
#
# usage: `find_acf_prop [filename.acf] [query]`
#
find_acf_prop ()
{

    acf_file="$1"
    query="$2"
    get_acf_prop "${acf_file}" "${query}"

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
        ls-acf)
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
# xprm "$@"
