#!/bin/sh
# ~/.zshrc: executed by zsh(1) for non-login shells.


if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Randomly switches terminal colors when opening a new window or tab
zsh-theme-switcher
