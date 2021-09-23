#!/bin/bash
source "/usr/lib/bash/libconfig"

cfg_exit_on_unset level

if (( `cfg_isnum level` )); then
        plevel=$level
else
        plevel=0
fi