# Load fzf completion and key bindings.
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi
