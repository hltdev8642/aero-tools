#!/bin/bash

#Includes the library into the script
source "/usr/lib/bash/libconfig"

#If the config file exists, include it
config="test.conf"
cfg_exit_on_no_conf config
source "$config"

#Checks if 'level' variable is set and is a valid number
cfg_exit_on_unset level
if (( `cfg_isnum level` )); then
        plevel=$level
else
        plevel=0
fi

#Checks if 'name' variable is set
if (( `cfg_isset name` )); then
        pname=$name
else
        pname="Unknown"
fi

echo "Hi $pname!"
echo "Level: $plevel"
