#!/usr/bin/env bash


# This file contains functions and commands for backing up information
# not acquired simply by a dotfile like currently installed packages


CUR_PATH=$(pwd)

function backupPikaur {
    echo "Backing up pikaur database..."

    pikaur -Qqe > "$CUR_PATH/pikaur/pkglist.txt"

    echo "Pikaur database backup completed"
}

function backupZsh {
    echo "Backing up zsh dotfiles"

    cp ~/.zsh* "$CUR_PATH"/zsh/

    echo "zsh dotfiles backup completed"
}


function backupVim {
    echo "Backing up Vim dotfiles"

    cat ~/.viminfo > "$CUR_PATH/vim/.viminfo"
    cat ~/.vimrc > "$CUR_PATH/vim/.vimrc"

    echo "Vim dotfile backup completed"

    echo "Backing up NeoVim dotfiles"

    cat $HOME/.config/nvim/init.vim > "$CUR_PATH/nvim/init.vim"

    echo "NeoVim dotfile backup completed"
}


function backupGit {
    echo "Backing up Git dotfiles"

    cat ~/.gitconfig > "$CUR_PATH/git/.gitconfig"

    echo "Git dotfiles backup completed"
} 


function backupAlacritty {
    echo "Backing up alacritty.yml"

    cp $HOME/.alacritty.yml $CUR_PATH/alacritty/

    echo "Alacritty backup completed"
}

function backupI3wm {
    echo "Backing up i3 config dotfile"
    cp $HOME/.config/i3/config $CUR_PATH/i3/
    echo "Backing up rofi config dotfile"
    cp $HOME/.config/rofi/config $CUR_PATH/rofi/
    echo "Completed"
}

function fullBackup {
    backupPikaur
    backupZsh
    backupVim
    backupGit
    backupAlacritty
    backupI3wm
}
