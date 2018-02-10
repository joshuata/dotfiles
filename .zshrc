fpath+=~/.zfunc

## Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

test -e ${HOME}/.pythonrc && export PYTHONSTARTUP=~/.pythonrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
