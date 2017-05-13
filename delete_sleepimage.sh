#!/bin/bash

##############################
# Removes the sleepimage file from memory--frees a ton of space
######

CYAN=6
YELLOW=3
RED=1
GREEN=2
MAGENTA=5

main() {
    tput setaf $MAGENTA
    printf "\nSLEEPIMAGE REMOVER\n"
    tput sgr0

    update_homebrew
    cleanup_homebrew_files
    delete_system_sleep_image
    exit_script
}

delete_system_sleep_image() {
    echo "Searching for 'sleepimage' file in directory '/private/var/vm/'..."
    sleep 2

    # check for sleepimage file in default location
    if [ -f /private/var/vm/sleepimage ]; then
        tput setaf $YELLOW
        echo "Sleepimage detected"
        tput sgr0
        echo "Deleting 'sleepimage'..."
        echo "Please enter your password..."
        {
            sudo rm -rf /private/var/vm/sleepimage
        } &> /dev/null
        
        #echo "Deleting 'sleepimage'...`sudo rm -rf /private/var/vm/sleepimage`"
        tput setaf $GREEN
        echo "Sleepimage removed successfully"
        tput sgr0
    else
        tput setaf $RED
        echo "Error: File not found in the specified directory."
        tput sgr0
        echo "Skipping procedure..."
    fi
}

exit_script() {
    echo "Cleanup complete"
    exit 0
}

update_homebrew() {
    echo "Updating homebrew..."
    echo `brew update -v`
    echo `brew upgrade -v`
    tput setaf $YELLOW
    echo "Brew updated successfully"
    tput sgr0
}

cleanup_homebrew_files() {
    echo "Cleaning up homebrew files..."
    tput setaf $YELLOW
    echo "`brew cleanup -v`Brew successfully cleaned"
    tput sgr0
}

main

