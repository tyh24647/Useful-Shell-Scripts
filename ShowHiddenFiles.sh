#!/bin/bash

####################################################################
# Shows or hides hidden files in Finder
#
# Allows for user specification of on or off, as
# well as toggles the settings if an argument is not
# passed in by the user
#
# NOTE: Must be executed by a user with administrative
# privelages
#
# 
# AUTHOR:   Tyler Hostager
# VERSION:  1.0.0
# DATE:     12-3-17
#
# Copyright (c) Tyler Hostager, 2017. All Rights Reserved.
#################################################################


## Init defaults
DF_NUM_ARGS=1
DF_VAL=$FALSE
DF_MAX_ARGS=1
DF_USR_ARGS_STR="FALSE"
DF_SHOUILD_PARSE_SETTINGS=$TRUE

## Init variables
NUM_ARGS=$#
PARSED_USR_ARGS_VAL=$FALSE
DEF_USR_NUM_ARGS=-1
USR_ARGS_ST=""
SHOULD_PARSE_SETTINGS=$FALSE


## Execute script when called
##
## NOTE: Must exec as admin or root user
main() {
    echo "\'DISPLAY HIDDEN FILES\' ADMIN SCRIPT"
    init_with_defaults
    echo "> Number of arguments detected: \'$NUM_ARGS\'"
    
    echo "> Applying specified settings..."
    {
        
    } &> /dev/null; sleep 2

}

init_with_defaults() {
    calc_num_args
}

parse_usr_args() {
    ## TODO parse the user input and number of arguments
}

parse_usr_settings() {
    ## TODO parse the user settings
}

calc_num_args() {
    num_args=-1

    if [ $# -eq 0 ] || [ $NUM_ARGS -eq 0 ] || [ $NUM_ARGS -eq $DEF_USR_NUM_ARGS ] || [ $# -le 0 ]; then
        echo "> No user arguments not detected"
        echo "> Setting to default values..."
        {
            $NUM_ARGS=${DF_NUM_ARGS}
            $USR_ARGS_STR="${DF_USR_ARGS_STR}"
            
            if [ $USR_ARGS_STR -le 0 ]; then
                parse_usr_settings
            elif [ $USR_ARGS_STR -eq 1 ]; then
                parse_usr_args
            else
                echo "> ERROR: Invalid usage. Please enter either \"TRUE\", \"FALSE\", or leave blank."
                echo ">"
            fi

            #TODO assign num_args
        } &> /dev/null; sleep 2
    else
        echo "> User arguments detected"
        echo "> Assigning values after parsing..."
        {
            parse_usr_args

            if [ $# -gt 0 ]; then
                if [ $USR_ARGS_ST -ne "TRUE" ] || [ $USR_ARGS_ST -ne "FALSE" ]; then
                    parse_usr_settings

                    #recursively re-enter method
                    calc_num_args
                else
                fi
            elif [ $USR_ARGS_ST -eq "TRUE" ] || [ $USR_ARGS_ST -eq "FALSE" ]; then
                num_args=1
            else
                is_true=$FALSE
                if [ $USR_ARGS_ST -eq "True" ] || [ $USR_ARGS_ST -eq "true" ] || [ $USR_ARGS_ST -eq "YES" ] 
                    || [ $USR_ARGS_ST -eq "yes" ] || [ $USR_ARGS_ST -eq "Yes" ] || [ $USR_ARGS_ST -eq "1" ]; then
                    is_true=$TRUE
                    num_args=1
                    $NUM_ARGS_ST="TRUE"
                elif [ $USR_ARGS_ST -eq "False" ] || [ $USR_ARGS_ST -eq "false" ] || [ $USR_ARGS_ST -eq "NO" ]
                    || [ $USR_ARGS_ST -eq "no" ] || [ $USR_ARGS_ST -eq "No" ] || [ $USR_ARGS_ST -eq "0" ]; then
                    num_args=1
                    $NUM_ARGS_ST="FALSE"
                else
                    echo "> ERROR: Unable to parse input parameters. Please only enter up to one valid argument"
                    echo "> Please re-run with the valid input"
                    echo ">"
                    echo "> Exiting script..."
                    {
                        exit 0
                        echo "> Script exited successfully"
                    }
                fi
            fi
        } &> /dev/null; sleep 2

        #TODO do something with is_true
    fi

    $NUM_ARGS=num_args
}


main

