fpath+=~/.zfunc

## Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

if type fzf > /dev/null 2>&1; then
  alias preview="fzf --preview 'bat --color \"always\" {}'"
fi

if type htop > /dev/null 2>&1; then
  alias top="sudo htop"
fi

if type exa > /dev/null 2>&1; then
  alias ls="exa"
fi

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

. /Users/joshuata/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# added by pipsi (https://github.com/mitsuhiko/pipsi)
export PATH="/Users/joshuata/.local/bin:$PATH"
