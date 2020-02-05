#!/usr/bin/env bash


# This file contains functions and commands for backing up information
# not acquired simply by a dotfile like currently installed packages


CODE_SETTINGS_LOCATION="$HOME/.config/Code - OSS/User/settings.json"
CUR_PATH=$(pwd)


function backupVscode {
    echo "Backing up Visual Studio Code configuration..."

    codeExtensionList=$(code --list-extensions)
    settingsFile=$(cat "$CODE_SETTINGS_LOCATION")

    echo $codeExtensionList > "$CUR_PATH/vscode/codeExtensions.json"
    echo $settingsFile > "$CUR_PATH/vscode/codeSettings.json"

    echo "Visual Studio Code backup completed"
}


function backupPikaur {
    echo "Backing up pikaur database..."

    echo "Do you wish the backup to contain foreign packages (e.g. from AUR)?"

    select includeForeign in "Yes" "No"; do
        case $includeForeign in
	        Yes ) $(pikaur -Qqe > "$CUR_PATH/pikaur/pkglist.txt"); break;;
            No  ) $(pikaur -Qqen > "$CUR_PATH/pikaur/pkglist.txt");;
	    esac
    done

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
}


function backupGit {
    echo "Backing up Git dotfiles"

    cat ~/.gitconfig > "$CUR_PATH/git/.gitconfig"

    echo "Git dotfiles backup completed"
}


function fullBackup {
    backupVscode
    backupPikaur
    backupZsh
    backupVim
    backupGit
}