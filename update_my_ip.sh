#!/bin/bash

# Fetch the current IP address and store it in a variable
my_ip=$(curl -s https://ipinfo.io/ip)

# Read the content of my_ip.txt and store it in a variable
if [ -f my_ip.txt ]; then
    stored_ip=$(cat my_ip.txt)
else
    stored_ip=""
fi

# Compare the current IP with the stored IP
if [ "$my_ip" = "$stored_ip" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') IP didn't change since last session. No need to update." >> logs.txt
else
    # Write the new IP address to my_ip.txt
    echo "$my_ip" > my_ip.txt
    echo "$(date '+%Y-%m-%d %H:%M:%S') IP changed. Updated my_ip.txt." >> logs.txt
fi
