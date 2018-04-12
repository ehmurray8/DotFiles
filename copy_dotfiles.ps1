#Add file to shell:startup to copy new changes to .ideavimrc and .vimrc
cd $HOME/DotFiles
git pull
rm $HOME/.vimrc
rm $HOME/.ideavimrc
cp .vimrc $HOME/.vimrc
cp .vimrc $HOME/.ideavimrc
Add-Content $HOME/.ideavimrc 'set surround " Add surround.vim plugin'
cp .vrapperrc $HOME/.vrapperrc
cp .gitconfig $HOME/.gitconfig
