#!/bin/bash
# name: demo-get-props-multi-acf.sh
# auth: hltdev [hltdev8642@gmail.com]
# desc: demo/test script that gets the studio and version
#       for all .acf in current directory (recursive)
#

source ~/bin/xprm
for i in $(find -name "*.acf" -type f | xargs ); do
    echo "------------------------------"
    echo -e "\e[38;5;32mname:\e[0m"
    echo -e "\e[38;5;32m$i\e[0m" ;
    echo -e "\e[38;5;32mversion:\e[0m"
    echo -e "\e[38;5;34m$(get_acf_prop ${i} version)\e[0m" ;
    echo -e "\e[38;5;32mstudio:\e[0m"
    echo -e "\e[38;5;34m$(get_acf_prop ${i} Studio)\e[0m" ;
        echo "------------------------------"

done

