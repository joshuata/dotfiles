# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# export EDITOR='vim'
# export VISUAL='vim'

# if command -v pyenv 1>/dev/null 2>&1; then
  # eval "$(pyenv init -)"
  # eval "$(pyenv virtualenv-init -)"
# fi

export PATH="$HOME/.local/bin":"$PATH"

# Rust setup
export PATH="$HOME/.cargo/bin":"$PATH"
source $HOME/.cargo/env

# Python setup
export PATH="$HOME/Library/Python/2.7/bin":"$PATH"
export PATH="$HOME/Library/Python/3.7/bin":"$PATH"
if [ -e ${HOME}/.pythonrc ]; then export PYTHONSTARTUP=~/.pythonrc; fi

# Machine-specific setup
local SIMPLEHOSTNAME=$(hostname -s)
if [ -e $HOME/.zsh/env/$SIMPLEHOSTNAME.zsh ]; then
  source $HOME/.zsh/env/$SIMPLEHOSTNAME.zsh;
fi
