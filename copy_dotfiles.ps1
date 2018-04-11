#Add file to shell:startup to copy new changes to .ideavimrc and .vimrc
cd $HOME/DotFiles
git pull
rm ../.vimrc
rm ../.ideavimrc
cp .vimrc ../.vimrc
cp .vimrc ../.ideavimrc
Add-Content ../.ideavimrc 'set surround " Add surround.vim plugin'
cp .vrapperrc ../.vrapperrc
