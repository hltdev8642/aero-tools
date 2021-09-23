#!/bin/bash
# name: get-acf-perf.sh
# auth: hltdev [hltdev8642@gmail.com]
# desc: Gets aircraft performance data from contentzone.eurocontrol.int/aircraftperformance (by ICAO)
#


mkdir -p ./ACFPERF

cd "ACFPERF"

[[ -z $1 ]] && read -p "ICAO:" input || input="$1" ;

url="https://contentzone.eurocontrol.int/aircraftperformance/details.aspx?ICAO=${input}"

mkdir ./$input
cd $input

# curl "$url" >> "${input}-performance.html"
# pandoc "$input-performance.html" -o "$input-performance.pdf" --pdf-engine="weasyprint"

pandoc "https://contentzone.eurocontrol.int/aircraftperformance/details.aspx?ICAO=${input}" -o "${input}.pdf" --pdf-engine="weasyprint"

pandoc "https://contentzone.eurocontrol.int/aircraftperformance/details.aspx?ICAO=${input}" -o "${input}.html"

pandoc "https://contentzone.eurocontrol.int/aircraftperformance/details.aspx?ICAO=${input}" -o "${input}.md"

pandoc "https://contentzone.eurocontrol.int/aircraftperformance/details.aspx?ICAO=${input}" -o "${input}.docx"
