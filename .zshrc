export PATH=$HOME/bin:/usr/local/bin:$PATH
export PROMPT_COMMAND="history -a; history -n" 
case "$(uname)" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac


if [ $machine = "Mac" ]; then
    # Customize to your needs...
    function proxyOn {
        # Proxy setup
        # Need to set PROXY_ADDRESS and PROXY_PORT in .zshenv
        # PROXY_PORT needs to be a string, PROXY_ADDRESS needs to be the address unquoted
        # Also set SSID_PROXY_NAME in .zshenv

        source ~/.zshenv
        PROXY_USERNAME=$(printf $(security find-internet-password -s "${PROXY_ADDRESS}" | grep "acct" | cut -d '"' -f 4))
        PROXY_PASSWORD=$(printf $(security 2>&1 >/dev/null find-internet-password -gs "${PROXY_ADDRESS}" | cut -d '"' -f 2))
        PROXY="http://${PROXY_USERNAME}:${PROXY_PASSWORD}@${PROXY_ADDRESS}:${PROXY_PORT}"
        export http_proxy="${PROXY}"
        export HTTP_PROXY="${PROXY}"
        export https_proxy="${PROXY}"
        export HTTPS_PROXY="${PROXY}"
        unset PROXY_ADDRESS
        unset PROXY_PORT
        unset PROXY_USERNAME
        unset PROXY_PASSWORD
        unset PROXY
        echo "Proxy tunnel enabled"
    }

    function proxyOff {
        unset http_proxy
        unset HTTP_PROXY
        unset https_proxy
        unset HTTPS_PROXY
        echo "Proxy tunnel disabled"
    }

    AIRPORT_CMD="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
    WIFI_OFF=$($AIRPORT_CMD -I | grep 'AirPort: Off')
    if [ ! -z "$WIFI_OFF" ]; then
        proxyOn
    else
        SSID=$($AIRPORT_CMD -I | awk '/ SSID/ {printf substr($0, index($0, $2))}')
        if [ "$SSID" = $SSID_PROXY_NAME ]; then
            proxyOn
        fi;
        unset SSID
    fi;

    unset WIFI_OFF
    unset AIRPORT_CMD
    export TERM="xterm-256color"
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'

    function xc() {
        project_file=$(find -E . -maxdepth 2 -regex ".*\.(xcodeproj|xcworkspace)$" | \
            grep -v "xcodeproj/project.xcworkspace" | \
            grep -v Pods | \
            sort -r | \
            head -1)
        if [ -z "$project_file" ]
        then
            echo "Couldn't find a workspace or a project to open."
        else
            echo "Opening $project_file..."
            open $project_file -a /Applications/Xcode.app
        fi
    }
fi

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

# OH-MY-ZSH Config
ZSH_THEME="agnoster"
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
set t_vb=

prompt_dir() {
    prompt_segment blue black "${PWD##*/}"
}

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


# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
