#!/bin/sh

##############################
# Removes the sleepimage file from memory--frees a ton of space
######

main() {
    sudo rm -rf /private/var/vm/sleepimage
    exit 0
}

main

