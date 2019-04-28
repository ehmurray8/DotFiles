#!/bin/bash

###
# TODO: Add support for command line arguments to only run parts of the script, i.e. only links
# TODO: Add support for asking to install other programs, i.e. VSCode, PyCharm, Firefox
# TODO: Look into installing programs on windows and Linux
###

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac


declare -a filesToLink=( ".bashrc" ".gitconfig" ".tmux.conf" ".vimrc" "add-gitignore" )

if [ "$machine" = "Mac" ]; then
    filesToLink[${#filesToLink[*]}]=$".macos"
    filesToLink[${#filesToLink[*]}]=$".tmux-osx.conf"
    filesToLink[${#filesToLink[*]}]=$".zshrc"
    echo "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Installing programs using brew..."
    brew bundle
    echo "Setting up Mac defaults..."
    ./.macos
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    brew install tree
    brew install tmux
    brew install nvim
    brew install the_silver_searcher
elif [ "$machine" = "Linux" ]; then
    filesToLink[${#filesToLink[*]}]=$".zshrc"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
elif [ "$machine" = "Cygwin"] || [ "$machine" = "MinGw" ]; then
    filesToLink[${#filesToLink[*]}]=".vrapperrc"
    filesToLink[${#filesToLink[*]}]="Microsoft.PowerShell_profile.ps1"
fi

echo "Linking DotFiles..."

replaceFile=false
for file in "${filesToLink[@]}"; do
    if [ -e "$HOME/$file" ]; then
        if [ "$replaceFile" = true ]; then
            rm "$HOME/$file"
        else
            checking=true
            while [ "$checking" = true ]; do
                read -p "Replace $file (Y/N/A) " prompt
                if [ "$prompt" = "Y" ] || [ "$prompt" = "y" ]; then
                    checking=false
                    rm "$HOME/$file"
                    ln -s "$PWD/$file" "$HOME/$file"
                elif [ "$prompt" = "N" ] || [ "$prompt" = "n" ]; then
                    checking=false
                elif [ "$prompt" = "A" ] || [ "$prompt" = "a" ]; then
                    checking=false
                    replaceFile=true
                fi
            done
        fi
    else
        ln -s "$PWD/$file" "$HOME/$file"
    fi
done

nvimFile="$HOME/.config/nvim/init.vim"
mkdir -p "$HOME/.config/nvim/"
if [ -e "$nvimFile" ]; then
    if [ replaceFile = true ]; then
        rm "$nvimFile"
        ln -s "$PWD/init.vim" "$nvimFile"
    else
        checking=true
        while [ checking = true ]; do
            read -p "Replace $nvimFile (Y/N) " prompt
            if [ prompt = "Y" ] || [ prompt = "y" ]; then
                rm "$nvimFile"
                ln -s "$PWD/init.vim" "$nvimFile"
                checking = false
            elif [ prompt = "N" ] || [ prompt = "n" ]; then
                checking=false
            fi
        done
    fi
else
    ln -s "$PWD/init.vim" "$nvimFile"
fi

if [ "$machine" = "Mac" ] || [ "$machine" = "Linux" ] ; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
