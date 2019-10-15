declare -a filesToLink=( ".bashrc" ".gitconfig" ".tmux.conf" ".vimrc" "add-gitignore" ".zshrc" )


replaceFile=false
for file in "${filesToLink[@]}"; do
    echo $file
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
        touch "$HOME/$file"
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
