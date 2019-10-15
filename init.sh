#!/bin/bash

###
# TODO: Add support for command line arguments to only run parts of the script, i.e. only links
# TODO: Add support for asking to install other programs, i.e. VSCode, PyCharm, Firefox
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
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    pip3 install --user pynvim
fi
