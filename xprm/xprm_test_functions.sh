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
