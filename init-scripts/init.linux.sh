filesToLink[${#filesToLink[*]}]=$".Xmodmap"
filesToLink[${#filesToLink[*]}]=$".xinitrc"
filesToLink[${#filesToLink[*]}]=$"add_app"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
