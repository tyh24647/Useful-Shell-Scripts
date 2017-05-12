#!/bin/bash

#################################################################
# This script applies a different (randomized) theme when       #
# a new terminal tab or window is opened.                       #
#                                                               #
# the purpose of this script is to provide a visual contrast    #
# between terminal windows so that it is easier to keep track   #
# of the respective terminal windows.                           #
#                                                               #
# This script is intended to be run via an alias in the .bashrc #
# file,                                                         #
#                                                               #
# Author:   Tyler Hostager, 2017.                               #
# Version:  1.0.0b1                                             #
#################################################################

# init constant vars
readonly NUM_ARGS=$#
readonly MIN_ARGS=0
readonly MAX_ARGS=15
readonly PARENT_DIR="$(dirname "$0")"
readonly DEFAULD_THEME_OPTIONS=("Basic" "Grass" "Homebrew" "Man Page" "Novel" "Ocean" "Pro" "Purple" "Red Sands" "Silver Aerogel" "Solid Colors")
readonly THEME_SCPT_FILE="bin/TermTheme.scpt"

# vars
IS_CUSTOM_DIR=false
CUSTOM_DIR_FLAG="-f"
CUSTOM_DIR=""
EXEC_SCRIPT=true
DIR_IS_VALID=false
ERR_MSG=""

main() {
    printf "\n\n- TERMINAL COLOR SWITCHER -\n"
    
    # ensure the script is being executed from the correct parent folder
    verify_directory

    while [ $EXEC_SCRIPT ]; do

    done
    
    
}

verify_directory() {
    printf "verifying directory..."
    
    if [ -z $PARENT_DIRECTORY ]; then
        DIR_IS_VALID=false
        ERR_MSG="Invalid directory.\nPlease ensure that this script is placed in the appropriate parent folder"
    else
        printf "> Checking directory for required file \'${THEME_SCPT_FILE}\""
        if [ -f $THEME_SCPT_FILE ]; then
            printf "> SUCCESS: File was found in directory"
            DIR_IS_VALID=true
        fi

        printf "> Directory verified and is valid"
    fi
}

prompt_usr_err() {
    error_message=""
    max_num_args=2

    if [ $ERR_MSG -eq "" ]; then
        if [ $# -gt 0 ]; then
            for msg in "$@"; do
                error_message=$error_message+=$"msg"
            done
        else
            return
        fi
    else
        error_message=$ERR_MSG
    fi

    printf $"> ERROR: $error_msg"
}

main

