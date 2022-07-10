#!/bin/bash

filename=`echo $(date +'%Y-%m-%d-%s')`
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
END='\033[0m'

echo -e """${CYAN} 

███████╗░█████╗░██████╗░
╚════██║██╔══██╗██╔══██╗
░░███╔═╝███████║██████╔╝
██╔══╝░░██╔══██║██╔═══╝░
███████╗██║░░██║██║░░░░░
╚══════╝╚═╝░░╚═╝╚═╝░░░░░

"""
if [ $1 != '' ] || [ $2 != '' ] || [ $3 != '' ] || [ $4 != '' ] || [ $5 != '' ] || [ $6 != '' ] ;
then
	sleep 2
	printf "${GREEN}[+]${YELLOW} Target${CYAN}\\n"
	echo ${1}
	echo $'\n'
	sleep 1
	printf "${GREEN}[+]${YELLOW} Entering Username and  Password\\n"
	#Getting cookies using python script
	cookie=`python3 login.py ${1} ${2} ${3} ${4} ${5} ${6}`
	echo $'\n'
	printf "${GREEN}[+]${YELLOW} Cookie ${CYAN}\\n"
	echo ${cookie}
	echo $'\n'
	printf "${GREEN}[+]${YELLOW} Updated Cookie ${CYAN}\\n"
	newcookie=`printf "%s" ${cookie} | tr -d {}\' | tr \: \= | tr \, \;`
	echo ${newcookie}
	echo $'\n'
	#Starting ZAP SCAN
	python /zap/zap-full-scan.py -I -j -m 10 -T 60 \
	-t "${1}" \
	-z "-config globalexcludeurl.url_list.url.enabled=true -config globalexcludeurl.url_list.url.regex='.*logout.*' -config replacer.full_list\(0\).description=desc -config replacer.full_list\(0\).enabled=true -config replacer.full_list\(0\).matchtype=REQ_HEADER -config replacer.full_list\(0\).matchstr=Cookie -config replacer.full_list\(0\).regex=false -config replacer.full_list\(0\).replacement='${newcookie}'" \
	-r $filename.html
	printf "${YELLOW}[i]${END} Done scanning \\n"
	echo $'\n'
	printf "${YELLOW}[i]${END} Report - $filename.html \\n"
else
	printf "${YELLOW}[i]${END} Please select the right options\\n"
fi
