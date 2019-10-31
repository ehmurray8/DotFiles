#!/bin/bash

###
# TODO: Look into installing programs on windows and Linux
# TODO: Install README programs in script.
###

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [ "$machine" = "Mac" ]; then
   source init-scripts/init.mac.sh
elif [ "$machine" = "Linux" ]; then
    ln -s "$PWD/add_app" "$HOME/add_app"
    source init-scripts/init.linux.sh
fi

echo "Linking DotFiles..."
source init-scripts/init.link-files.sh

if [ "$machine" = "Mac" ] || [ "$machine" = "Linux" ] ; then
    source init-scripts/init.oh-my-zsh.sh
    curl https://sh.rustup.rs -sSf | sh
    source $HOME/.cargo/env
    cargo install sd
fi
