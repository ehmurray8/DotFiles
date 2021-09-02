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


echo "Installing oh-my-zsh..."
if [ "$machine" = "Mac" ] || [ "$machine" = "Linux" ]; then
    source init-scripts/init.oh-my-zsh.sh
    curl https://sh.rustup.rs -sSf | sh
    source $HOME/.cargo/env
    cargo install sd
    source $HOME/.zshrc
fi


echo "Linking DotFiles..."
source init-scripts/init.link-files.sh

echo "Installing nvm..."
/bin/bash -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash)"

echo "Installing COCPlugins"
/bin/bash -c '$(nvim -c "CocInstall -sync coc-css coc-eslint coc-highlight coc-html coc-json coc-pairs coc-prettier coc-snippets coc-tsserver coc-vetur")'


echo "================================================================================"
echo "Next Steps"
echo "================================================================================"
echo ""
echo "1. Run tmux"
echo "2. Run Ctrl + a + I"
echo "3. Open a file with `v {fileName}`"
echo "4. Run :PlugInstall and then quit out of everything"
echo "5. Set iTerm font to Hack Nerd Font Mono 13pt"
echo "6. Open a file with `v {fileName}`"
echo "7. Set the iTerm background color by using color picker to the same background color as neovim background"
echo "8. Create a ~/work/.gitconfig so that git uses proper email"
echo "9. Map Caps Lock to Escape key"
echo "10. Restart Mac for preferences to kick in"
echo "================================================================================"
