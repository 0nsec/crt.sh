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
echo -e "\e[32m[+]\e[0m 𝙼𝚊𝚍𝚎 𝚋𝚢: 0nsec «--•}"
echo -e "\e[32m[+]\e[0m 𝙶𝙸𝚃𝙷𝚄𝙱: Github.com/0nsec"
echo -e "\e[32m[+]\e[0m 𝚄𝚜𝚊𝚐𝚎: $0 [-v] [-o json|text] [-d delay] domain1 domain2 ..."
echo ""

# Variables
VERBOSE=false
OUTPUT_FORMAT="text"
DELAY=1
ERROR_LOG="error.log"

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo -e "\e[31m[!]\e[0m Error: 'jq' is not installed."
    echo -e "\e[32m[+]\e[0m Install 'jq' using one of the following commands:"
    echo -e "\e[32m[+]\e[0m Arch Linux: sudo pacman -S jq"
    echo -e "\e[32m[+]\e[0m Debian/Ubuntu: sudo apt install jq"
    echo -e "\e[32m[+]\e[0m macOS: brew install jq"
    echo -e "\e[32m[+]\e[0m Windows: choco install jq"
    exit 1
fi

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -o|--output)
            OUTPUT_FORMAT="$2"
            shift 2
            ;;
        -d|--delay)
            DELAY="$2"
            shift 2
            ;;
        *)
            DOMAINS+=("$1")
            shift
            ;;
    esac
done

# Check if domains are provided
if [ ${#DOMAINS[@]} -eq 0 ]; then
    echo -e "\e[31m[!]\e[0m Error: No domains provided."
    echo -e "\e[32m[+]\e[0m Usage: $0 [-v] [-o json|text] [-d delay] domain1 domain2 ..."
    exit 1
fi

# Function to perform the search
search() {
    local domain="$1"
    local output_file="output/$domain.$OUTPUT_FORMAT"

    # Create output directory if it doesn't exist
    mkdir -p output

    # Fetch certificate data from crt.sh
    if $VERBOSE; then
        echo -e "\e[32m[+]\e[0m Fetching data for domain: \e[31m$domain\e[0m"
    fi
    requestsearch="$(curl -s "https://crt.sh?q=%.$domain&output=json")"

    # Check if the request was successful
    if [ -z "$requestsearch" ]; then
        echo -e "\e[31m[!]\e[0m Failed to fetch data for domain: $domain" >> "$ERROR_LOG"
        return
    fi

    # Process the data using jq
    if $VERBOSE; then
        echo -e "\e[32m[+]\e[0m Processing data for domain: \e[31m$domain\e[0m"
    fi
    if [ "$OUTPUT_FORMAT" == "json" ]; then
        echo "$requestsearch" | jq . > "$output_file"
    else
        echo "$requestsearch" | jq -r ".[].common_name,.[].name_value" | sed 's/\\n/\n/g' | sed 's/\*.//g' | sed -r 's/([A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4})//g' | sort | uniq > "$output_file"
    fi

    # Display results
    if $VERBOSE; then
        echo -e "\e[32m[+]\e[0m Results for \e[31m$domain\e[0m:"
        echo -e "\e[34m----------------------------------------\e[0m"
        cat "$output_file"
        echo -e "\e[34m----------------------------------------\e[0m"
    fi
    echo -e "\e[32m[+]\e[0m Total domains found for \e[31m$domain\e[0m: \e[31m$(cat "$output_file" | wc -l)\e[0m"
    echo -e "\e[32m[+]\e[0m Output saved in \e[31m$output_file\e[0m"
}

# Main loop to process domains
for domain in "${DOMAINS[@]}"; do
    search "$domain"
    sleep "$DELAY" # Rate limiting
done