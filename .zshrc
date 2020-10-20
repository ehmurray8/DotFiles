# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/.cargo/bin:$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH
export PROMPT_COMMAND="history -a; history -n"

# FZF Config
FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_CTRL_R_OPTS="--preview-window right:40% --preview 'echo {}'"
export LANG=en_US.UTF-8

export TERM="xterm-256color"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# https://unix.stackexchange.com/questions/273861/unlimited-history-in-zsh
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# OH-MY-ZSH Config
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
    git
    vi-mode
    zsh-syntax-highlighting
    history-substring-search
)

export ZSH=~/.oh-my-zsh

HYPHEN_INSENSITIVE="true"

ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

unsetopt beep
set visualbell

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export NVM_DIR="$HOME/.nvm"
 [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
 [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias v='nvim'
alias agi='~/add-gitignore'
alias g='git'
alias ddd="rm -Rf $HOME/Library/Developer/Xcode/DerivedData/*"
alias xvim="open -a /Applications/Xcode+Vim.app"
alias t='tmux'
alias tkill="tmux kill-session -t"
alias tnew="tmux new -t"
alias tattach="tmux attach-session -t"
alias pping="~/prettyping --nolegend"
alias preview="fzf --preview 'bat --color=\"always\" {}'"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias jv="~/jsonviewer"

function mouseOn {
    sd "(set -g mouse (on|off))" "set -g mouse on" ~/.tmux.conf
    tmux source-file ~/.tmux.conf
}

function mouseOff {
    sd -i "(set -g mouse (on|off))" "set -g mouse off" ~/.tmux.conf
    tmux source-file ~/.tmux.conf
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zshrc.local

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
