filesToLink[${#filesToLink[*]}]=$".tmux-osx.conf"

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    
echo "Installing programs using brew..."
brew bundle

brew tap homebrew/cask-fonts
brew cask install font-anonymous-nerd-font
    
echo "Setting up Mac defaults..."    
./.macos

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
