#!/bin/bash

# Function to fetch current IP address
get_current_ip() {
    curl -s https://ipinfo.io/ip
}

# Function to log messages to logs.txt
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> logs.txt
}

# Function to perform git pull with suppressed output
git_pull() {
    git pull --quiet
}

# Function to perform git commit with message and suppress output
git_commit() {
    git commit -am "$1" --quiet
}

# Function to perform git push with suppressed output
git_push() {
    git push --quiet
}

# Perform a git pull to update the local repository
git_pull

# Fetch current IP address
my_ip=$(get_current_ip)

# Read the stored IP address from my_ip.txt
if [ -f my_ip.txt ]; then
    stored_ip=$(cat my_ip.txt)
else
    stored_ip=""
fi

# Compare current IP with stored IP
if [ "$my_ip" = "$stored_ip" ]; then
    log_message "IP didn't change since last session. No need to update."
else
    # Write the new IP address to my_ip.txt
    echo "$my_ip" > my_ip.txt
    
    # Commit the change with a message including the current time
    commit_message="IP changed at $(date '+%Y-%m-%d %H:%M:%S')"
    git_commit "$commit_message"
    
    # Push the changes to the remote repository
    git_push
    
    log_message "IP changed to $my_ip. Updated my_ip.txt."
fi
