#!/bin/bash

####
# ALIASES
alias zsh-theme-switcher=zsh-theme-switcher

####
# GLOBAL VARS
THEME_SWITCHER_IS_VERBOSE=0

####
# HELPER METHODS
zsh-theme-switcher() {
    local VAR1=""
    local VAR2=""
    local NUM_VARS=$#

    if [ $# -gt 0 ]; then

        if [[ $# -ge 1 ]] && ( [[ "$1" = "-v" ]] || [[ "$1" = "--verbose" ]] ); then
            THEME_SWITCHER_IS_VERBOSE=1
            VAR1=$2
            VAR2=""
        elif [[ "$1" = "--help" ]] || [[ "$1" = "-h" ]]; then
            THEME_SWITCHER_IS_VERBOSE=1     # must be verbose to show help options

            if [ $# -gt 2 ]; then
                VAR1="$2"
                
                if [ $# -eq 3 ]; then
                    VAR2="$3"
                fi
            else
                VAR1="$1"

                if [ $# -eq 2 ]; then
                    VAR2="$2"
                fi
            fi
        else
            VAR1="$1"

            if [ $# -gt 1 ]; then
                VAR2="$2"
            fi
        fi
    fi

    debug_log "\n>>> ZSH THEME SWITCHER"
    
<<<<<<< HEAD
    local OPTIND options
=======
    local OPTIND option
>>>>>>> test
    while getopts ":default:verbose:name:path:random:help:tyler:help:d:v:n:p:r:t:h:" option; do
        case "$option" in

            default) {
                echo -e ">>> Applying randomly selected zsh theme ..."
                {
                    theme=''
                } &> /dev/null
            };;

            name) {
                if [[ $VAR1 = *"~/"* ]] || [[ $VAR1 = *"/"* ]]; then
                    TMP_FILE_NAME="${VAR1,,}"     # convert to lowercase to check for theme file name

                    if [[ -f "~/.oh-my-zsh/themes/${TMP_FILE_NAME}.zsh-theme" ]]; then      # check if theme file with the specified name exists
                        debug_log ">>> Theme already exists at the specified path"; sleep_verbose 1;
                        debug_log ">>> Replacing theme data with the data from the specified version of the theme ..."
                        echo -e ""; {
                            sleep_verbose 3
                                
                            if [[ -f "~/.oh-my-zsh/themes/${TMP_FILE_NAME}.zsh-theme" ]]; then
                                sleep_verbose 1
                            else
                                debug_log ">>> ERROR: Unable to replace the file with the replacement file with the specified name"
                                debug_log ">>>   Ensure that you have valid permissions to the folders"
                                debug_log ">>>   Try re-running the command using the 'sudo' prefix"
                                debug_log ">>>"
                                debug_log ">>> For syntax/command implementation details, use the command flags '--help' or '-h'"
                                debug_log ""
                                {
                                    return 1
                                } &> /dev/null
                            fi

                            debug_log ">>> File replaced successfully!"
                        } &> /dev/null
                        
                        debug_log ">>> Assigning theme name..."
                        {
                            theme="$VAR2" | tr '[:upper:]' '[:lower:]'
                            #theme="${VAR2^^}"
                            sleep_verbose 2
                            debug_log ">>> Name successfully assigned!"
                        } &> /dev/null
                    fi
                else
                    debug_log ">>> ERROR: Unable to locate file at the specified path"
                    debug_log ">>>   Please enter a valid filepath using the following syntax: 'zsh-theme-switcher --path ~/path/to/my/file.zsh-theme'"
                    debug_log ">>>"
                    debug_log ">>> For syntax/command implementation details, use the command flags '--help' or '-h'"
                    return 1
                fi
            };;
            
            path) {
                if [ -f "$VAR2" ]; then
                    if [ -f $option ]; then
                        TMP_FILE_NAME=$(sed -e 's/~/\(.*\).zsh-theme/\1/')

                        if [[ $TMP_FILE_NAME = "" ]]; then
                            debug_log ">>> Parsing file name to 'TerminalSwitcher.scpt' format ..."
                            echo -e ""
                            {
                                TMP_FILE_NAME=$(sed -e 's//\(.*\).zsh-theme/\1/')
                                sleep_verbose 2
                            } &> /dev/null
                            
                            if [[ $TMP_FILE_NAME = "" ]]; then
                                debug_log ">>> ERROR: Invalid file path specified"
                                debug_log ">>>    Make sure the path string is valid"
                                debug_log ">>>    Ensure that the file exists in the specified location"
                                debug_log ">>>"
                                debug_log ">>> For syntax/command implementation details, use the command flags '--help' or '-h'"
                                echo -e ""; {
                                    return 1
                                } &> /dev/null
                            fi
                        fi

                        if [[ -f "~/.oh-my-zsh/themes/${TMP_FILE_NAME}.zsh-theme" ]]; then
                            debug_log ">>> Theme file already exists"
                            debug_log ">>> applying existing theme..."
                            {
                                theme="$TMP_FILE_NAME" | tr '[:upper:]' '[:lower:]'
                                #theme="${TMP_FILE_NAME^^}"
                                sleep_verbose 2
                                debug_log ">>> Theme applied successfully!"
                            } &> /dev/null
                        else 
                            echo -e ">>> Copying file from the specified path to the 'zsh' themes directory at path '~/.oh-my-zsh/themes/' ..."
                            {
                                echo -e $(cp ${VAR2} ~/.oh-my-zsh/themes)
                                sleep_verbose 4

                                if [ -f ~/.oh-my-zsh/themes/${TMP_FILE_NAME,,}.zsh-theme ]; then
                                    debug_log ">>> Theme successfully copied!"
                                else
                                    debug_log ">>> ERROR: Unable to copy theme file from the specified path\n>>>\tEnsure you have the proper file permissions\n>>>\tTry re-running the command with the 'sudo' prefix\n>>>\n>>> For syntax and command implementation details, use the command flags '--help' or '-h'"
                                    debug_log ""
                                    {
                                        return 1
                                    } &> /dev/null
                                fi
                            }
                        fi
                    fi
                fi
            };;

            random) theme='' ;;

            tyler) {
                if [[ -f ~/.oh-my-zsh/themes/tyler.zsh-theme ]]; then
                    theme='TYLER'
                else
                    debug_log ">>> ERROR: Unable to perform the requested option - Could not locate theme file named 'tyler.zsh-theme'\n>>>\tEnsure that 'oh-my-zsh' is installed before running this command\n>>>\tEnsure that there is a valid file named 'tyler.zsh-theme' installed to the '~/.oh-my-zsh/themes/'\n>>>\t>>> For syntax and command implementation details, use the command flags '--help' or '-h'"
                    debug_log ""
                    {
                        return 1
                    } &> /dev/null
                fi
            };;     
            
            d) theme='' ;;
            
            v) THEME_SWITCHER_IS_VERBOSE=1 ;;

            n) {
                if [[ $VAR2 = *"~/"* ]] && [[ $VAR2 = *"/"* ]]; then
                    TMP_FILE_NAME="${VAR2,,}"     # convert to lowercase to check for theme file name

                    if [[ -f "~/.oh-my-zsh/themes/${TMP_FILE_NAME}.zsh-theme" ]]; then      # check if theme file with the specified name exists
                        debug_log ">>> Theme already exists at the specified path"; sleep_verbose 1;
                        debug_log ">>> Replacing theme data with the data from the specified version of the theme ..."
                        {
                            sleep_verbose 3
                            
                            if [[ -f "~/.oh-my-zsh/themes/${TMP_FILE_NAME}.zsh-theme" ]]; then
                                sleep_verbose 1
                            else
                                debug_log ">>> ERROR: Unable to replace the file with the replacement file with the specified name\n>>>\tEnsure that you have valid permissions to the folders\n>>>   Try re-running the command using the 'sudo' prefix\n>>>\n>>> For syntax/command implementation details, use the command flags '--help' or '-h'"
                                debug_log ""
                                {
                                    return 1
                                } &> /dev/null
                            fi
                        } &> /dev/null
                        
                        debug_log ">>> File replaced successfully!"
                        {
                            theme="$VAR2" | tr '[:upper:]' '[:lower:]'
                            #theme="${VAR2^^}"
                            sleep_verbose 1
                        } &> /dev/null
                    else
                        debug_log ">>> ERROR: Unable to locate file at the specified path"
                        debug_log ">>>   Please enter a valid filepath using the following syntax: 'zsh-theme-switcher --path ~/path/to/my/file.zsh-theme'"
                        debug_log ">>>"
                        debug_log ">>> For syntax/command implementation details, use the command flags '--help' or '-h'"
                        debug_log ""
                        {
                            return 1
                        } &> /dev/null
                    fi
                fi
            };;
            
            p) {
                if [ -f $VAR2 ]; then
                    if [ -f $option ]; then
                        TMP_FILE_NAME=sed -e 's/~/\(.*\).zsh-theme/\1/'

                        if [[ $TMP_FILE_NAME = "" ]]; then
                            debug_log ">>> Parsing file name to 'TerminalSwitcher.scpt' format..."
                            {
                                TMP_FILE_NAME=sed -e 's//\(.*\).zsh-theme/\1/'
                                sleep_verbose 2
                            } &> /dev/null
                            
                            if [[ $TMP_FILE_NAME = "" ]]; then
                                debug_log ">>> ERROR: Invalid file path specified"
                                debug_log ">>>   Make sure the path string is valid"
                                debug_log ">>>   Ensure that the file exists in the specified location"
                                debug_log ">>>"
                                debug_log ">>> For syntax/command implementation details, use the command flags '--help' or '-h'"
                                debug_log ""
                                {
                                    return 1
                                } &> /dev/null
                            fi
                        fi

                        if [[ -f "~/.oh-my-zsh/themes/${TMP_FILE_NAME}.zsh-theme" ]]; then
                            debug_log ">>> Theme file already exists"
                            debug_log ">>> applying existing theme..."
                            {
                                theme="$TMP_FILE_NAME" | tr '[:upper:]' '[:lower:]'
                                #theme="${TMP_FILE_NAME^^}"
                                sleep_verbose 2
                                debug_log ">>> Theme applied successfully!"
                            } &> /dev/null
                        else 
                            debug_log ">>> Copying file from the specified path to the 'zsh' themes directory at path '~/.oh-my-zsh/themes/'..."
                            {
                                cp $VAR2 ~/.oh-my-zsh/themes
                                #cp ${VAR2,,} ~/.oh-my-zsh/themes
                                sleep_verbose 4

                                if [ -f ~/.oh-my-zsh/themes/${TMP_FILE_NAME,,}.zsh-theme ]; then
                                    debug_log ">>> Theme successfully copied!"
                                else
                                    debug_log ">>> ERROR: Unable to copy theme file from the specified path"
                                    debug_log ">>>   Ensure you have the proper file permissions"
                                    debug_log ">>>   Try re-running the command with the 'sudo' prefix"
                                    debug_log ">>> For syntax and command implementation details, use the command flags '--help' or '-h'"
                                    debug_log ""
                                    {
                                        return 1
                                    } &> /dev/null
                                fi
                            }
                        fi
                    fi
                fi
            };;

            r) theme='' ;;

            t) {
                if [ -f ~/.oh-my-zsh/themes/tyler.zsh-theme ]; then
                    theme='TYLER'
                else
                    debug_log ">>> ERROR: Unable to perform the requested option - Could not locate theme file named 'tyler.zsh-theme'"
                    debug_log ">>>   Ensure that 'oh-my-zsh' is installed before running this command"
                    debug_log ">>>   Ensure that there is a valid file named 'tyler.zsh-theme' installed to the '~/.oh-my-zsh/themes/'"
                    debug_log ">>>"
                    debug_log ">>> For syntax and command implementation details, use the command flags '--help' or '-h'"
                    
                    debug_log ""; {
                        return 1
                    } &> /dev/null
                fi
            };;

            h) {
                debug_log ">>>\n\n\tCOMMAND HELP - 'zsh-theme-switcher':\n\nFLAGS:\n\t[--name   |  -n]: Apply theme file with name\n\t[--path   |  -p]: Apply custom theme file at path\n\t[--help   |  -h]: Display 'help' options\n\t[--tyler  |  -t]: Apply standard 'tyler' theme\n\t[--help  |  -h]: Show command help options\n\t[--random |  -r]"
                debug_log ""
                debug_log "      PERMISSIONS: If you do not have the proper permissions, try re-running the command using the 'sudo' prefix (i.e. 'sudo zsh-theme-switcher BASIC')"
                debug_log ""
            };;

            ?) {
                if [ $# -eq 0 ] || ( [ $# -eq 1 ] && [ $THEME_SWITCHER_IS_VERBOSE -eq 1 ] ) ; then
                    debug_log ">>> Applying random color theme..."; {
                        theme=""
                        sleep_verbose 2
                    } &> /dev/null
                elif [ $# -gt 1 ]; then
                    if [ $THEME_SWITCHER_IS_VERBOSE=0 ]; then
                        CUSTOM_ARG_NAME="$VAR1" | tr '[:lower:]' '[:upper:]'
                        
                        if [ $# -eq 2 ]; then
                            if [[ $option = *"-n"* ]] || [[ $option = *"--name"* ]]; then
                                debug_log ">>> Searching for theme file with name '$VAR1'..."
                                {
                                    sleep_verbose 3
                                } &> /dev/null
                                
                                if [[ ! -f "~/.oh-my-zsh/themes/${$,,}.zsh-theme" ]]; then
                                    debug_log ">>> ERROR: File not found at path '~/.oh-my-zsh/themes/${$VAR1,,}.zsh-theme'"
                                    debug_log ">>> Skipping procedure..."
                                    {
                                        sleep_verbose 2
                                    } &> /dev/null
                                fi

                                debug_log ">>> Parsing and formatting theme name ..."; {
                                    theme="$VAR1" | tr '[:upper:]' '[:lower:]'
                                }
                            fi
                        else
                            debug_log ">>>"
                            debug_log ">>> ERROR: Unable to execute command - Invalid command options and/or flags used"
                            debug_log ">>>"
                            debug_log ">>> For syntax and command implementation details, use the command flags '--help' or '-h'"
                            debug_log ""
                            {
                                return 1
                            } &> /dev/null
                        fi
                    fi
                elif [ $# -gt 0 ]; then
                    TMP_FILE_NAME = ${option^^}

                    if [ -f $TMP_FILE_NAME ]; then
                        debug_log "Loading theme file named '${VAR1}'..."
                        theme="${option,,}"

                    else
                        debug_log ">>> "
                        debug_log ">>> ERROR: Unable to load theme file - File not found"
                        debug_log ">>>   Make sure a theme with the specified name is installed to the '~/.oh-my-zsh/themes/' directory"
                        debug_log ">>>   Make sure the filetype has the extension format of 'my-file-name.zsh-theme'"
                        debug_log ">>>"
                        debug_log ">>> For syntax and command implementation details, use the command flags '--help' or '-h'\n"; {
                            return 1
                        } &> /dev/null
                    fi
                fi
            };;
        esac
    done

    if [ $THEME_SWITCHER_IS_VERBOSE=1 ]; then
        debug_log ">>> Applying theme '${VAR1}' ..."    
    fi

    sleep_verbose 2
    osascript ~/Desktop/Useful\ Scripts/Terminal\ theme\ switcher/bin/TermTheme.scpt ${VAR1}

    debug_log ">>> Theme successfully applied!"
    debug_log ""
    debug_log "The command completed successfully with exit code: 0."
    debug_log ""; {
        VAR1=""
        VAR2=""
        THEME_SWITCHER_IS_VERBOSE=0
        return 0
    } &> /dev/null
}

function debug_log() {
    if [ $THEME_SWITCHER_IS_VERBOSE -eq 1 ]; then
        echo -e "$(echo -e "$1")"
    fi
}

function sleep_verbose() {
    if [ $THEME_SWITCHER_IS_VERBOSE -eq 1 ]; then
        sleep $1
    fi
}

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi
