#!/bin/sh

#############################################################################
# GoServer allows for simple server connections by creating the GoServer
# command.
#
# Tyler Hostager
# 5/1/15
#############################################################################



## Init local vars
ROOT_USER="tyh24647"		# 	<-- Assign root user to tyh24647-to be changed per user
SERVER_TITLE=""
SPECIFICATIONS=""
SERVER_ADDRESS=""
END_TAG=""
NUM_ENTRIES=$#
FIRST_ENTRY=$1




## Displays error message to the console when appropriate
disp_usr_error() {
    echo "\n\t* ERROR: Invalid usage. Please specify a server name. *\n"
    echo "Enter \"GoServer -h\" or \"GoServer --help\" for further details and example usages\n"
}



## Displays help messages to the user if selected after unsuccessful connection
disp_help_msgs() {
    echo "\nEXAMPLE USAGES:"
    echo "\"GoServer footprints xp\", \"GoServer blink\", etc."
}



## Assigns the appropriate server title, if appropriate
set_svr_title() {
    if [ "${FIRST_ENTRY}" = "-h" ] || [ "${FIRST_ENTRY}" = "--help" ]; then
        SERVER_TITLE=""
        disp_help_msgs
    else
        SERVER_TITLE="${FIRST_ENTRY}"
    fi
    set_svr_addr
}



## Checks validity of user entries
validate_usr_submissions() {
    if [ ${NUM_ENTRIES} -eq 0 ]; then	# User made no entry after GoServer name
        disp_usr_error        
    elif [ ${NUM_ENTRIES} -eq 1 ]; then		# User specified server title, no additional specifications
        set_svr_title
    fi
}



## Checks for specified servers that don't have "its" the address
set_svr_addr() {
    if [ ${FIRST_ENTRY} = 'BLink' ] || [ ${FIRST_ENTRY} = 'blink' ] || [ ${FIRST_ENTRY} = 'Blink' ] || [ ${FIRST_ENTRY} = 'footprints' ] || [ ${FIRST_ENTRY} = 'Footprints' ] || [ ${FIRST_ENTRY} = 'FootPrints' ] || [ ${FIRST_ENTRY} = 'Confluence' ] || [ ${FIRST_ENTRY} = 'confluence' ]; then
        END_TAG='.bethel.edu'
    else #				<-- include 'its' in address name
        END_TAG='.its.bethel.edu'        
    fi   
    SERVER_ADDRESS="${SERVER_TITLE}${END_TAG}"
}



## Attempts connection to the specified server using the given input
init_server_connection() {
    echo "> Attempting to establish a secure connection with the \"${SERVER_TITLE}\" server..."
    echo "> Connecting to \"${SERVER_ADDRESS}\" with root user \"${ROOT_USER}\""
    echo ""
    ssh ${ROOT_USER}@${SERVER_ADDRESS}
    echo ""
    echo ""
}



## Connect to server
main() {
    if [ ${NUM_ENTRIES} -eq 1 ] && [ ${FIRST_ENTRY} != "-h" ] && [ ${FIRST_ENTRY} != "--help" ]; then
        validate_usr_submissions
        init_server_connection
    fi
}



main #  	<-- Executes program


