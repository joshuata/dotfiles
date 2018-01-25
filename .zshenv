#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]];
then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export EDITOR='vim'
export VISUAL='vim'

export PATH="$HOME/.local/bin":"$PATH"

# Rust setup
export PATH="$HOME/.cargo/bin":"$PATH"
source $HOME/.cargo/env


# Haskell setup
export PATH="$HOME/Library/Haskell/bin":"$PATH"
export PATH="$HOME/.cabal/bin:$PATH"

export PATH="$HOME/Library/Python/2.7/bin":"$PATH"

export SIMPLEHOSTNAME=$(hostname -s)
if [ -e $HOME/.zsh/$SIMPLEHOSTNAME.zsh ]; then
  source $HOME/.zsh/$SIMPLEHOSTNAME.zsh;
fi
