#!/bin/bash

#####################################################################
# Re-enables the System Preferences option to allow software
# to be installed from any developer (unsigned or unidentified).
#
# This feature is missing from macOS Sierra
#
# Author: Tyler Hostager
# Version: 05/21/17
#####################################################################

NUM_PARAMETERS=$#
SHOULD_ENABLE=false
USER_INPUT=""

init() {
    ## make sure the input is valid before execution
    validate_user_input
}

validate_user_input() {
    if [ ${NUM_PARAMETERS} -eq 0 ]; then
        printf "No parameters specified -> Enabling by default.\n\n\tAdd the flag \'--help\' for instructoins on how to disable this setting\n" 
        SHOULD_ENABLE=true
    elif [ ${NUM_PARAMETERS} -le 2 ]; then
        if [ $1 -ne "" ]; then
            USER_INPUT=$1
            
            if [ $USER_INPUT -eq "--enable" ] || [ $USER_INPUT -eq "-e" ]; then
                SHOULD_ENABLE=true
            elif [ $USER_INPUT -eq "--disable" ] || [ $USER_INPUT -eq "-d" ]; then
                SHOULD_ENABLE=false
            elif [ $USER_INPUT -eq "--help" ] || [ $USER_INPUT -eq "-h" ]; then
                SHOULD_ENABLE=false
                printf "\nPARAMETER OPTIONS:\n\t\'--help\' or \'-h\': Show help menu\n\t\'--enable\' or \'-e\': Enable Allow apps downloaded from unidentified developers\n\t\'--disable\' or \'-d\': Disable apps downloaded from unidentified developers\n\n"
            else
                printf "ERROR: Invalid input parameters -> Disabling by default"
            fi
        else
            printf "ERROR: Invalid input parameters -> Disabling by default"
            SHOULD_ENABLE=false
        fi
    elif [ ${NUM_PARAMETERS} -ge 2 ]; then
        printf "ERROR: Invalid number of input parameters -> Disabling by default"
        SHOULD_ENABLE=false
    fi

    printf "Attempting to set value to preferences object..."
    printf "This may require an administrative password"
    if [ SHOULD_ENABLE == true ]; then
        printf "`sudo spctl --master-disable`\nPreference applied successfully"
        printf "Custom setting -> enabled"
    else
        printf "`sudo spctl --master-enable`\nPreference applied successfully"
        printf "Custom setting -> disabled"
    fi

    echo "`exit_script`"
}

exit_script() {
    printf "Exiting script..."
    echo "`exit 0`\nApplication terminated"
}

## called upon initialization
main() {
    printf "Enabling option to allow applications to be installed from unrecognized developers..."
    init
    printf "Security preference added to the app \'System Preferences\'"
}

## initialize script
main


