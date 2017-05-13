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
    output_colored "\nSLEEPIMAGE REMOVER" $MAGENTA
    update_homebrew
    cleanup_homebrew_files
    delete_system_sleep_image
    exit_script
}

delete_system_sleep_image() {
    echo "Searching for 'sleepimage' file in '/private/var/vm/'..."
    sleep 2

    # check for sleepimage file in default location
    if [ -f /private/var/vm/sleepimage ]; then
        output_colored "Sleepimage detected" $YELLOW
        
        echo "Deleting 'sleepimage'..."
        echo "Please enter your password..."
        {
            sudo rm -rf /private/var/vm/sleepimage
        } &> /dev/null
        
        output_colored "Sleepimage file removed successfully" $GREEN
    else
        output_colored "Error: File not found in the specified directory." $RED
        echo "Skipping procedure..."
    fi
}

exit_script() {
    echo "Cleanup complete"
    exit 0
}

update_homebrew() {
    echo "Updating and cleaning homebrew..."
    echo `brew update -v`
    echo "Done"
    echo "upgrading homebrew..."
    echo `brew upgrade -v`
    echo "Done"
}

cleanup_homebrew_files() {
    echo "Cleaning up homebrew files..."
    output_colored "`brew cleanup -v`Brew cleaned successfully" $GREEN
}

output_colored() {
    color=-1
    msg=""

    if [ $# -ge 2 ]; then   # if input is more than 2 params, only use first two
        msg=$1
        color=$2
    elif [ $# -eq 1 ]; then
        msg=$1
    elif [ $# -le 0  ]; then
        return
    fi

    # set color if applicable
    if [ $color -ne -1 ] && [ $color -ge 0 ]; then
        tput setaf $color
    fi

    echo $msg
    tput sgr0
}

main

