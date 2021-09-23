#!/bin/bash
#
# name: getFAACharts [v1.1.0]
# auth: hltdev [hltdev8642@gmail.com]
# desc: Get FAA Airport charts via nfdc.faa website.
#

get_opts=$(cat ${HOME}/.faa-charts-path-cfg 2>/dev/null )

if [[ ! -z $get_opts ]]; then
    FAA_CHART_PATH=$get_opts
else
    FAA_CHART_PATH="${PWD}/FAA-CHARTS"
    mkdir -p $FAA_CHART_PATH
    cd ${FAA_CHART_PATH}
fi


function installDeps()
{
    sudo apt install wget poppler
}

original_dir=$PWD

function toUpperCase()
{
    echo "${@:1}" | tr '[:lower:]' '[:upper:]'
}

function genMergedPDF()
{
    pdfunite *.PDF merged.pdf

}


[ -z "$1" ] && read -p "Airport ID: " airport_id || airport_id="$1" ;

airport_id=$( toUpperCase "$airport_id" )

base_url="https://nfdc.faa.gov/nfdcApps/services/ajv5/airportDisplay.jsp"
airport_suffix="?airportId="
full_url="${base_url}/${airport_suffix}${airport_id}"
# https://nfdc.faa.gov/nfdcApps/services/ajv5/airportDisplay.jsp?airportId=BOS
# curl "$full_url" | exturls -
# curl "${base_url}/${airport_suffix}${airport_id}"

# mkdir -p "./FAA-CHARTS/${airport_id}/"
mkdir -p "$FAA_CHART_PATH"
mkdir -p "$FAA_CHART_PATH/${airport_id}"

# cd "./FAA-CHARTS"
cd "$FAA_CHART_PATH/"


curl "https://nfdc.faa.gov/nfdcApps/services/ajv5/airportDisplay.jsp?airportId=$airport_id" \
    | grep --binary-files=text  -Eo \
    '(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]' \
    | sort --unique \
    | ag "(.*)\.{1}pdf" >> "$airport_id.txt"

cd "./${airport_id}"

wget -i "../${airport_id}.txt" --quiet -N   2>/dev/null
# rm 'viewer_redirect.cfm?viewer=pdf&amp;server_name=employees.'
genMergedPDF
cd $original_dir
# genMergedPDF
chmod 775 $FAA_CHART_PATH/ -R

