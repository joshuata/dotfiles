# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export PATH="$HOME/.local/bin":"$PATH"

# Machine-specific setup
setopt NULL_GLOB
for file in $HOME/.zsh/env/*.zsh; do
    source "$file"
done
unsetopt NULL_GLOB
