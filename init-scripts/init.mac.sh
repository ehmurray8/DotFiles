filesToLink[${#filesToLink[*]}]=$".tmux-osx.conf"

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    
echo "Installing programs using brew..."
brew bundle

echo "Installing fonts from brew..."
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
    
echo "Setting up Mac defaults..."    
./.macos

echo "Setting up Vim Plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
