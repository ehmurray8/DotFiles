declare -a filesToLink=( ".bashrc" ".gitconfig" ".tmux.conf" ".vimrc" "add-gitignore" ".zshrc" "jsonviewer" "prettyping" ".p10k.zsh" )

replaceFile() {
    rm "$HOME/$file"
    linkFile
}

linkFile() {
    ln -s "$PWD/$file" "$HOME/$file"
}

replaceAllFiles=false
for file in "${filesToLink[@]}"; do
    if [ -e "$HOME/$file" ]; then
        if [ "$replaceAllFiles" = true ]; then
            replaceFile
        else
            checking=true
            while [ "$checking" = true ]; do
                read -p "Replace $file (Y/N/A) " prompt
                if [ "$prompt" = "Y" ] || [ "$prompt" = "y" ]; then
                    checking=false
                    replaceFile
                elif [ "$prompt" = "N" ] || [ "$prompt" = "n" ]; then
                    checking=false
                elif [ "$prompt" = "A" ] || [ "$prompt" = "a" ]; then
                    checking=false
                    replaceAllFiles=true
                    replaceFile
                fi
            done
        fi
    else
        linkFile
    fi
done

nvimFile="$HOME/.config/nvim/init.vim"
mkdir -p "$HOME/.config/nvim/"
if [ -e "$nvimFile" ]; then
    if [ replaceAllFiles = true ]; then
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

cocSettingsFile="$HOME/.config/nvim/coc-settings.json"
if [ -e "$nvimFile" ]; then
    if [ replaceAllFiles = true ]; then
        rm "$cocSettingsFile"
        ln -s "$PWD/coc-settings.json" "$cocSettingsFile"
    else
        checking=true
        while [ checking = true ]; do
            read -p "Replace $cocSettingsFile (Y/N) " prompt
            if [ prompt = "Y" ] || [ prompt = "y" ]; then
                rm "$cocSettingsFile"
                ln -s "$PWD/coc-settings.json" "$cocSettingsFile"
                checking = false
            elif [ prompt = "N" ] || [ prompt = "n" ]; then
                checking=false
            fi
        done
    fi
else
    ln -s "$PWD/coc-settings.json" "$cocSettingsFile"
fi
