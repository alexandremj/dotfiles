#!/usr/bin/env bash


# Scripts regarding system configuration after a new install


function installPikaur {
    echo "Installing pikaur..."

    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/pikaur.git
    cd pikaur
    makepkg -fsri
    cd ..
    rm -rf pikaur

    echo "pikaur installed"
}


function shellConfiguration {
    echo "Starting shell configuration..."
    pikaur -S zsh

    chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    pikaur -S alacritty
    cp ./alacritty/.alacritty.yml $HOME_DIR/

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

    echo "Shell configuration concluded"
}


function installTextEditors {
    echo "Installing text editors..."

    pikaur -S nvim

    echo "NeoVim installed"
}


function gitConfiguration {
    echo "Configuring git..."

    git config --global user.name "Alexandre Muller Junior"
    git config --global user.email "alexandremj@pm.me"
    git config --global core.editor nvim

    echo "Git configuration concluded"
}


function installLanguageTools {
    echo "Installing tools for programming languages..."

    # python
    echo "Installing tools for programming languages... [Python]"
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python get-pip.py --user
    rm get-pip.py

    pip install virtualenv --user

    # nodejs
    echo "Installing tools for programming languages... [JavaScript]"
    pikaur -S nodejs npm

    echo "pip, virtualenv, nodejs interpreter and npm installed"
}


function configurePostgreSQL {
    echo "Configuring PostgreSQL..."
    pikaur -S postgresql

    sudo -iu postgres
    initdb -D /var/lib/postgres/data
    sudo systemctl start postgres.service
    sudo systemctl enable postgres.service

    createuser --superuser alexandremj
    createdb

    echo "PostgreSQL configured"
}


function installOtherApps {
    echo "Installing other applications..."

    pikaur -S lutris spotify popcorntime telegram-desktop vlc

    echo "Lutris, Spotify, Popcorntime, Telegram Desktop and VLC installed"
}


# This needs to run after installOtherApps so that lutris is installed on the system
function installGames {
    which lutris || echo "lutris not found, exiting"; return 1;

    # Diablo 3
    echo "Installing Diablo 3..."
    wget "https://lutris.net/api/installers/diablo-iii-dxvk?format=json"
    lutris --install diablo-iii-dxvk?format=json && rm diablo-iii-dxvk?format=json
    echo "Diablo 3 installed"

    # Magic: the Gathering Arena
    echo "Installing Magic: the Gathering Arena"
    wget "https://lutris.net/api/installers/magic-the-gathering-arena-latest-self-updating?format=json"
    lutris --install magic-the-gathering-arena-latest-self-updating?format=json && rm "magic-the-gathering-arena-latest-self-updating?format=json"
    echo "Magic: the Gathering Arena installed"

}


function getDotfiles {
    git clone "https://github.com/alexandremj/dotfiles" || echo "Couldn't find the dotfiles repo. Are you connected to the internet?"; return 1;;

    echo "Start symlinking..."
    cd dotfiles

    # bash
    ln -sv bash/.bash_history ~/.bash_history
    ln -sv bash/.bash_logout ~/.bash_logout
    ln -sv bash/.bash_profile ~/.bash_profile
    ln -sv bash/.bashrc ~/.bashrc

    # vim
    ln -sv vim/.viminfo ~/.viminfo
    ln -sv vim/.vimrc ~/.vimrc

    # zshfiles are not working with symlinks so copy them to the desired place instead
    cp zsh/.zsh* ~

    # vscode
}
