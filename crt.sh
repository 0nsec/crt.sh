#!/bin/bash
echo -e "
\e[32m[+]\e[0m π³πππππ ππππππ ππππππ :
\e[32m[+]\e[0m πΌπππ ππ’:
\e[32m[+]\e[0m BΒ₯ Notyoursxx0 Β«--β’}
\e[32m[+]\e[0m πΆπΈππ·ππ± :
\e[32m[+]\e[0m Github.com/0nsec
        "
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
                echo "USAGE: $0 [domain.com] "
                exit
        else
                domain=$1
fi

if [ -z $2 ]
then
search
fi
