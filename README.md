# DotFiles
Dot files for use on Mac and Linux machines. Run the init.sh script to setup default configuration, and link dotfiles.


## Programs

* File Searching
`fd - https://github.com/sharkdp/fd`

* Cat alternative with syntax highlighting
`bat - https://github.com/sharkdp/bat`

* Terminal multiplexer
`tmux - https://github.com/tmux/tmux`

* Text editor
`neovim - https://github.com/neovim/neovim`

* Find and replace, sed alternative
`sd - https://github.com/chmln/sd`

* Grep/Ack alternative for searching
`ag - https://github.com/ggreer/the_silver_searcher`

* Bash alternative
`zsh - https://www.zsh.org/`

* Plugin/Settings manager for zsh
`oh-my-zsh - https://github.com/robbyrussell/oh-my-zsh/`

* Ping alternative
`prettyping - https://github.com/denilsonsa/prettyping`

* Fuzzy finder for finding files, autocomplete, history search, and more
`fzf - https://github.com/junegunn/fzf`

* Interactive system resource diagnostic tool
`htop - https://github.com/hishamhm/htop`

* Better diffs
`diff-so-fancy - https://github.com/so-fancy/diff-so-fancy`

* Disk usage
`ncdu - https://github.com/rofl0r/ncdu`

* Quick help on a command
`tldr - https://github.com/tldr-pages/tldr`

## Tutorials
* fzf - https://www.youtube.com/watch?v=qgG5Jhi_Els
* gitconfig - https://gist.github.com/rab/4067067
* tmux:
    - https://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/
    - https://github.com/gpakosz/.tmux
    - https://hackernoon.com/a-gentle-introduction-to-tmux-8d784c404340
    - https://leanpub.com/the-tao-of-tmux/read#troubleshoot-site-paths

* git aliases - https://www.atlassian.com/blog/git/advanced-git-aliases
* git - https://statico.github.io/vim3.html
* vim - https://statico.github.io/vim3.html
* cli - https://remysharp.com/2018/08/23/cli-improved


## Zsh
Install syntax highlighting plugin by running the following command:
`git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

## Tmux
The `./tmux-catppuccin/tmux-dark-notify-theme.conf` file must be placed at `~/.local/state/tmux/tmux-dark-notify-theme.conf`. Don't create a symbolic link
as tmux-dark-notify will be creating symbolic links.

The `./tmux-catppuccin/catppuccin.conf`, `./tmux-catppuccin/catppuccin_light.conf`, and `./tmux-catppuccin/catppuccin.tmux` 
files must exist at `~/.tmux/plugins/tmux`.

Add the following line as the second instruction to the `~/.tmux/plugins/tmux/catppuccin_tmux.conf` file, so the top looks like this:

```
source -F "#{d:current_file}/themes/catppuccin_#{@catppuccin_flavor}_tmux.conf"

set -g window-style "bg=#{@thm_bg},fg=#{@thm_fg}"
```

## ETC
* Nerd Fonts - https://github.com/ryanoasis/nerd-fonts
* Switch between nerdtree and file - C-wC-w
* Tmux colors - https://superuser.com/questions/285381/how-does-the-tmux-color-palette-work/1104214#1104214
* Powerline config- https://powerline.readthedocs.io/en/latest/configuration/segments/common.html
* Mac colors - https://stackoverflow.com/a/68456561


## Local config
* Create a file in ~ called .zshrc.local and add any local zshrc configuration to the file
    - java_home

## Git Work Config
* Add any work specific repos to a work directory, and include a .gitconfig file in this directory with the correct email to use

## Deoplete issue
`pip3 install neovim --user`
https://github.com/Shougo/deoplete.nvim/issues/550

## Helpful Scripts
* add_gitignore (agi) adds a standardized gitignore file to the current directory, pulled from github
* add_app script for creating linux desktop entries
* jsonviewer script for prettifying json
