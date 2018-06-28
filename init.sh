#!/bin/sh

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
    #/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Installing programs using brew..."
    #brew bundle
    echo "Setting up Mac defaults..."
    #./.macos
elif [ "$machine" = "Linux" ]; then
    filesToLink[${#filesToLink[*]}]=".zshrc"
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

if [ "$machine" = "Mac" ]; then
    echo  "Setting up Zim..."
    git clone --recursive https://github.com/zimfw/zimfw.git ${ZDOTDIR:-${HOME}}/.zim
    setopt EXTENDED_GLOB
    for template_file in ${ZDOTDIR:-${HOME}}/.zim/templates/*; do
        user_file="${ZDOTDIR:-${HOME}}/.${template_file:t}"
        touch ${user_file}
        ( print -rn "$(<${template_file})$(<${user_file})" >! ${user_file} ) 2>/dev/null
    done
    chsh -s =zsh
    echo "Please open a new terminal window, and type the following command..."
    echo "source ${ZDOTDIR:-${HOME}}/.zlogin"
fi
