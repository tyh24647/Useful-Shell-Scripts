###############################################################################################
# README.txt
#
# This document serves to aid the end user with running, modifying, and editing
# the contents of the scripts included in the downloaded scripts folder. Please be mindful 
# that the methods in this document may be archaic/outdated, and that
# the developer of these scripts may not, under any circumstances, be held responsible for
# any possible damage/unwanted outcomes that resulted from running these scripts.
#
# If you are modifying any of the files in this scripts package, do so at your own risk, and
# I would recommend either saving the original documents in a duplicate location before
# the modifications, or using Git or another form of version control to track and/or reverse
# any unwanted changes.
#
# Contact info - If you have questions, contact me here and I will respond as soon as I can
#   - GitHub:   https://github.com/tyh24647
#   - Reddit:   https://www.reddit.com/user/tylero056/
#   - Gmail:    tyhostager@gmail.com
#
# Author:       Tyler Hostager
# Last Edited:  5/11/17
###############################################################################################


------------------------------
 INSTRUCTIONS AND USER GUIDE:
------------------------------
This script only works with existing terminal themes that are included in your 
'com.apple.Terminal.plist' file located in the ~/Library/Preferences/ folder. 
If you can't access the ~/Library folder (it is hidden by default), do one 
of the following steps:
    
PLIST ACCESS VIA FINDER
    1.) Open finder and press cmd+shift+G and type ~/Library/Preferences in the 
        search box and hit enter.
    2.) Open finder and click "Go" on the top status bar, then press 'shift', and
        the "Library" option should show up in the list. Select this, and it will
        open the folder in a new finder window.
    
PLIST ACCESS VIA TERMINAL
    - Type "cd ~/Library/Preferences" and hit enter
    - Type "ls" and hit enter to list all files, and the file should show up in this list.
        
----------------------------------------------------------------------------------------------

THEME MANAGEMENT
    - To create a new theme or modify a current theme, open up Terminal.app and
        navigate to "Preferences" -> "Profiles" and then click the '+' sign on the 
        bottom left to create a new theme.
    - Themes are modified in the window next to the table view showing the various
        installed themes. Use the various settings to edit the desired themes.

FILE MODIFICATION
    - If you are going to modify any of the files included in this folder, I would recommend
        creating duplicates of the files that you are going to modify, and save them in a 
        memorable location, so the originals can be restored at a later time.
    - If you are concerned about making irriversible changes to the files, or want to go back
        to a version of the file before you made a specific modification, a version control
        tool should be used, such as Git.

PROPERTY-LISTS
    - You can find your plist file using the steps listed above.
    - I have included my default terminal plist file, just in case you accidentally delete
        your own and don't have a backup, although it may include some of my customizations
        to the default terminal theme, so I would recommend finding and backing up your own
        file.
    - To find the original file, refer to the first point in this section.
    - I recommend editing these files using either Xcode or PrefSetter, because it will
        automatically format the documents in the desired format, and provide the correct 
        ways to manipulate them.
    - If you do choose to use a text editor, TextEdit is not recommended, as it has no way 
        of detecting the file type. For this reason use vi/vim editor in terminal, or with
        a 3rd-party text editor such as VS Code, Sublime Text, etc.

BASH AND SHELL SCRIPTS
    - If you do not have sudo access, you will not be able to modify and execute these commands
    - If you are unable to open/modify a file because you don't have the appropriate permissions,
        type the following command into terminal after navigating into the directory that has
        the document, then type "sudo chmod 666 MYFILENAMEHERE.sh", type your password, and hit
        enter. This will give you read and write permissions for the document.


