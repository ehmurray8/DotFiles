# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/emmet/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/emmet/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/emmet/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/emmet/.fzf/shell/key-bindings.zsh"
