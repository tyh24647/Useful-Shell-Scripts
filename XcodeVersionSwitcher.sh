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

main() {
    if [ ${NUM_RUNS} -eq 0 ]; then
        clear
        tput setaf 6
        echo ">>>  XCODE VERSION SELECTOR"
        tput sgr0
    fi

    # check for both original and beta Xcode applications at the default path
    tput setaf 2
    echo ">>> Scanning drive for Xcode applications..."
    tput sgr0
    tput setaf 2
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
            tput setaf 3
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

            tput setaf 2
        done
    fi

    while [ ${EXECUTE_CMD} == true ]; do
        NUM_RUNS=1
        tput setaf 3
        read -rsp '>>> Press any key to continue...' -n 1 key
        tput setaf 2

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
    tput setaf 3
    echo ">>> Current enabled Xcode version: "
    tput sgr0
    xcode-select -p
    tput setaf 3
    echo ">>> Current Swift version: "
    tput sgr0
    swift -version
}

validate_usr_input() {
    tput setaf 2
    echo ""
    echo ">>> validating input parameters..."
    tput sgr0

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
                        if [ "${USR_PARAM}" == "y" ]; then
                            VALID_INPUT=true
                            USE_BETA=true
                            return
                        elif [ "${USR_PARAM}" == "n" ]; then
                            VALID_INPUT=true
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

    tput setaf 2
    echo ">>> no parameters specified"
    tput sgr0

    tput setaf 3
    read -rp '>>> Enable Xcode beta? (y/n): ' -n 1 key
    tput sgr0
    USR_PARAM="$key"
    tput setaf 2

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
        tput setaf 2
        echo ""
        echo ">>> User input validated successfully"
        tput sgr0
    fi
}

assign_xcode_title() {
    tput setaf 2
    echo ">>> Assigning title..."
    tput sgr0
    
    if [ ${VALID_INPUT} == true ]; then
        if [ ${USE_BETA} == true ]; then
            USR_XCODE_TITLE=${XCODE_BETA_TITLE}
        else
            USR_XCODE_TITLE=${XCODE_TITLE}
        fi
        
        tput setaf 2
        echo ">>> Title successfully assigned --> \"${USR_XCODE_TITLE}\""
        tput sgr0
    else
        USR_ERR="Invalid input. Please enter a valid option"
        prompt_usr_err
        return
    fi
}

prompt_usr_err() {
    if [ "${USR_ERR}" != "" ]; then
        tput setaf 1
        echo "ERROR: ${USR_ERR}"
        tput sgr0

        if [ ${EXECUTE_CMD} == true ]; then
            tput setaf 2
            echo "Restarting procedure"
            tput sgr0
            main
        else
            tput setaf 2
            echo "Terminating operation"
            tput sgr0
            main
        fi

        tput setaf 2
    fi
}

enable_xcode_version() {
    tput setaf 2
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

    tput setaf 6
    echo ">>> Command executed successfully"
    tput sgr0

    EXECUTE_CMD=false
    main
}

trap_ctrlc() {
    tput setaf 2
    echo ""
    echo ">>> Cleaning..."
    tput sgr0
    clean_stdin
    tput setaf 2
    echo ">>> Cleaned successfully"
    tput sgr0
    tput setaf 2
    echo ">>> Exiting application"
    tput sgr0
    exit 2
}

clean_stdin() {
    #while [ read -r -t 0 ]; do
    #    read -n 256 -r -s
    #done
}

trap trap_ctrlc 2

main


