#!/bin/sh

###############################################################################################
#
#   Allows for quick switching between Xcode and the Xcode beta (Swift 3.0.1 and Swift 3.1)
#
#   Author:     Tyler Hostager
#   Version:    3/3/17
#
##############################################################################################

NUM_PARAMETERS=$#
USR_PARAM=$1
HAS_PARAM=false
USE_BETA=false
VALID_INPUT=true
EXECUTE_CMD=true
INVALID_CONT_OPTION=true
XCODE_TITLE="Xcode"
XCODE_BETA_TITLE="Xcode Beta"
USR_XCODE_TITLE=""
USR_ERR=""
NUM_RUNS=0
UP_KEY="\027[A"
DOWN_KEY="\027[B"
LEFT_KEY="\027[D"
RIGHT_KEY="\027[C"
DEFAULT_XCODE_APP="/Applications/Xcode.app/Contents/Developer"
DEFAULT_XCODE_BETA_APP="/Applications/Xcode-beta.app/Contents/Developer"
HEADER_TPUT=6
DEFAULT_TPUT=2
ERR_TPUT=1
PROMPT_TPUT=3

init() {
    if [ ${NUM_RUNS} -eq 0 ]; then
        clear
        tput setaf $HEADER_TPUT
        echo ">>>  XCODE VERSION SELECTOR"
        tput sgr0
    fi

    # check for both original and beta Xcode applications at the default path
    tput setaf $DEFAULT_TPUT
    echo ">>> Scanning drive for Xcode applications..."
    
    if [ -f "${DEFAULT_XCODE_APP}" ] && [ -f "${DEFAULT_XCODE_BETA_APP}" ]; then
        echo ">>> User \"$USER\" has the required applications" 
    else
        USR_ERR=">>> User \"$USER\" does not have the required \"${XCODE_TITLE}\" and \""${XCODE_BETA_TITLE}"\"  applications installed on the current drive"
        prompt_usr_err
        return
    fi

    # print current versions to console so it is clear which one they are using
    disp_enabled_xcode_version

    if [ ${NUM_RUNS} -ne 0 ]; then
        while [ ${INVALID_CONT_OPTION} == true ]; do
            tput setaf $PROMPT_TPUT
            read -rp '>>> Continue? (y/n): ' -n 1 key
            tput sgr0
            echo ""

            if [ "$key" == "n" ]; then
                EXECUTE_CMD=false
                INVALID_CONT_OPTION=false
                return
            elif [ "$key" == "y" ]; then
                EXECUTE_CMD=true
                INVALID_CONT_OPTION=false
            else
                USR_ERR="Invalid input--please select a valid option"
                prompt_usr_err
                INVALID_CONT_OPTION=true
            fi

            tput setaf $DEFAULT_TPUT
        done
    fi

    while [ ${EXECUTE_CMD} == true ]; do
        NUM_RUNS=1
        tput setaf $PROMPT_TPUT
        read -rsp '>>> Press any key to continue...' -n 1 key
        tput setaf $DEFAULT_TPUT

        # ensure that any parameters entered are valid
        validate_usr_input

        if [ ${VALID_INPUT} == true ]; then
            assign_xcode_title
            enable_xcode_version
        else
            prompt_usr_err
        fi
    done
}

disp_enabled_xcode_version() {
    tput setaf $PROMPT_TPUT
    echo ">>> Current enabled Xcode version: "
    tput sgr0
    xcode-select -p
    tput setaf $PROMPT_TPUT
    echo ">>> Current Swift version: "
    tput sgr0
    swift -version
}

validate_usr_input() {
    tput setaf $DEFAULT_TPUT
    echo ""
    echo ">>> validating input parameters..."

    if [ $# -ne 0 ]; then
        if [ ${NUM_PARAMETERS} -eq 1 ]; then
            HAS_PARAM=true
    
            if [ -z ${USR_PARAM} ]; then
                HAS_PARAM=false
            else
                if [ ${USR_PARAM} == "-b" ] || [ ${USR_PARAM} == "--beta" ]; then
                    VALID_INPUT=true
                    USE_BETA=true
                    return
                elif [ "${USR_PARAM}" == "-s" ] || [ "${USR_PARAM}" == "--standard" ]; then
                    VALID_INPUT=true
                    USE_BETA=false
                    return
                else
                    if [ "${USR_PARAM}" != "n" ] && [ "${USR_PARM}" != "y" ]; then
                        HAS_PARAM=false
                        USR_ERR="Invalid parameter specifications. Please enter a valid option"
                        VALID_INPUT=false
                        prompt_usr_err
                        return
                    else
                        VALID_INPUT=true
                        HAS_PARAM=true

                        if [ "${USR_PARAM}" == "y" ]; then
                            USE_BETA=true
                            return
                        elif [ "${USR_PARAM}" == "n" ]; then
                            USE_BETA=false
                            return
                        fi
                    fi
                fi
            fi
        else
            USR_ERR="Invalid number of parameters"
            prompt_usr_err
        fi
    fi

    echo ">>> no parameters specified"

    tput setaf $PROMPT_TPUT
    read -rp '>>> Enable Xcode beta? (y/n): ' -n 1 key
    tput sgr0
    
    USR_PARAM="$key"
    tput setaf $DEFAULT_TPUT

    if [ ${HAS_PARAM} == false ]; then
        if [ "${USR_PARAM}" != "y" ] && [ "${USR_PARAM}" != "n" ]; then
            VALID_INPUT=false
            return
        elif [ ${USR_PARAM} == "y" ]; then
            VALID_INPUT=true
            USE_BETA=true
        elif [ ${USR_PARAM} == "n" ]; then
            VALID_INPUT=true
            USE_BETA=false
        else
            USR_ERR="An unknown error occurred"
            prompt_usr_err
        fi
    fi

    if [ ${VALID_INPUT} == true ]; then
        echo ""
        echo ">>> User input validated successfully"
    fi

    tput sgr0
}

assign_xcode_title() {
    tput setaf $DEFAULT_TPUT
    echo ">>> Assigning title..."
    
    if [ ${VALID_INPUT} == true ]; then
        if [ ${USE_BETA} == true ]; then
            USR_XCODE_TITLE=${XCODE_BETA_TITLE}
        else
            USR_XCODE_TITLE=${XCODE_TITLE}
        fi
        
        echo ">>> Title successfully assigned --> \"${USR_XCODE_TITLE}\""
    else
        USR_ERR="Invalid input. Please enter a valid option"
        prompt_usr_err
    fi

    tput sgr0
}

prompt_usr_err() {
    if [ "${USR_ERR}" != "" ]; then
        tput setaf $ERR_TPUT
        echo "ERROR: ${USR_ERR}"
        tput setaf $DEFAULT_TPUT

        if [ ${EXECUTE_CMD} == true ]; then
            echo "Restarting procedure"
        else
            echo "Terminating operation"
        fi

        init
    fi
}

enable_xcode_version() {
    tput setaf $DEFAULT_TPUT
    echo ">>> This command may need root/administrative privelages in order to be executed..."

    # check for admin permisisons
    sudo -v

    echo ">>> Attempting to enable \""${USR_XCODE_TITLE}"\"... "
    tput sgr0

    if [ ${USE_BETA} == true ]; then
        sudo $USER xcode-select -s /Applications/Xcode-beta.app/Contents/Developer
    else
        sudo $USER xcode-select -s /Applications/Xcode.app/Contents/Developer
    fi

    tput setaf $HEADER_TPUT
    echo ">>> Command executed successfully"
    tput sgr0

    EXECUTE_CMD=false
    init
}

trap_ctrlc() {
    tput setaf $DEFAULT_TPUT
    echo ""
    echo ">>> Cleaning..."
    clean_stdin
    echo ">>> Cleaned successfully"
    echo ">>> Exiting application"
    tput sgr0

    # end script
    exit 2
}

clean_stdin() {
    #while [ read -r -t 0 ]; do
    #    read -n 256 -r -s
    #done
}

# captures 'ctrl-c' keycode and exits the program appropriately instead of halting
trap trap_ctrlc 2

# initializes the program
init


