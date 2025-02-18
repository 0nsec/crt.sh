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

# Function to perform the search
search() {
    # Create output directory if it doesn't exist
    mkdir -p output

    # Fetch certificate data from crt.sh
    echo -e "\e[32m[+]\e[0m Fetching data for domain: \e[31m$domain\e[0m"
    requestsearch="$(curl -s "https://crt.sh?q=%.$domain&output=json")"

    # Check if the request was successful
    if [ -z "$requestsearch" ]; then
        echo -e "\e[31m[!]\e[0m Failed to fetch data. Please check your connection or the domain name."
        exit 1
    fi

    # Save raw data to a temporary file
    echo "$requestsearch" > search.txt

    # Process the data using jq and save the results
    echo -e "\e[32m[+]\e[0m Processing data..."
    cat search.txt | jq -r ".[].common_name,.[].name_value" | sed 's/\\n/\n/g' | sed 's/\*.//g' | sed -r 's/([A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4})//g' | sort | uniq > output/$domain.txt

    # Clean up temporary file
    rm search.txt

    # Display results
    echo ""
    echo -e "\e[32m[+]\e[0m Results for \e[31m$domain\e[0m:"
    echo -e "\e[34m----------------------------------------\e[0m"
    cat output/$domain.txt
    echo -e "\e[34m----------------------------------------\e[0m"
    echo ""
    echo -e "\e[32m[+]\e[0m Total domains found: \e[31m$(cat output/$domain.txt | wc -l)\e[0m"
    echo -e "\e[32m[+]\e[0m Output saved in \e[31moutput/$domain.txt\e[0m"
}

# Check if a domain is provided as an argument
if [ -z "$1" ]; then
    echo -e "\e[31m[!]\e[0m Error: No domain provided."
    echo -e "\e[32m[+]\e[0m Usage: $0 [domain.com]"
    exit 1
else
    domain="$1"
fi

# Perform the search
search