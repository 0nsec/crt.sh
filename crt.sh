#!/bin/bash

# Cool Banner
echo -e "\e[34m"
echo "  ____                        _     ____                      _   _           "
echo " |  _ \  ___  _ __ ___   __ _| |_  / ___|  ___  __ _ _ __ ___| |_(_)_ __   ___ "
echo " | | | |/ _ \| '_ \` _ \ / _\` | __| \___ \ / _ \/ _\` | '__/ __| __| | '_ \ / _ \\"
echo " | |_| | (_) | | | | | | (_| | |_   ___) |  __/ (_| | | | (__| |_| | | | |  __/"
echo " |____/ \___/|_| |_| |_|\__,_|\__| |____/ \___|\__,_|_|  \___|\__|_|_| |_|\___|"
echo -e "\e[0m"
echo -e "\e[32m[+]\e[0m 𝙳𝚘𝚖𝚊𝚒𝚗 𝚂𝚎𝚊𝚛𝚌𝚑 𝚎𝚗𝚐𝚒𝚗𝚎"
echo -e "\e[32m[+]\e[0m 𝙼𝚊𝚍𝚎 �𝚢: Notyoursxx0 «--•}"
echo -e "\e[32m[+]\e[0m 𝙶𝙸𝚃𝙷𝚄𝙱: Github.com/0nsec"
echo -e "\e[32m[+]\e[0m 𝚄𝚜𝚊𝚐𝚎: $0 [domain.com]"
echo ""

search() {
	requestsearch="$(curl -s "https://crt.sh?q=%.$domain&output=json")"
		 
			 echo $requestsearch > search.txt
			 cat search.txt | jq ".[].common_name,.[].name_value"| cut -d'"' -f2 | sed 's/\\n/\n/g' | sed 's/\*.//g'| sed -r 's/([A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4})//g' |sort | uniq > output/$domain.txt
			 rm search.txt
			 echo ""
			 cat output/$domain.txt
			 echo ""
			 echo -e "\e[32m[+]\e[0m Total Save will be \e[31m"$(cat output/$domain.txt | wc -l)"\e[0m Domain only"
			 echo -e "\e[32m[+]\e[0m Output saved in output/$domain.txt"
}	 

if [ -z $1 ]
        then
                echo "USAGE: $0 [domain.com]"
                exit
        else
                domain=$1
fi

if [ -z $2 ]
then
search
fi
