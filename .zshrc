fpath+=~/.zfunc

### Added by Zplugin's installer
source "${HOME}/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

source "${HOME}/.zsh/plugins.zsh"

if (( $+commands[nvim] )); then
    alias vim='nvim'
fi

if (( $+commands[htop] )); then
    alias top="sudo htop"
fi

if (( $+commands[exa] )); then
    alias ls="exa"
fi

if (( $+commands[fasd] )); then
    alias j='fasd_cd -d'
    alias a='fasd -a'
    alias s='fasd -si'
    alias sd='fasd -sid'
    alias sf='fasd -sif'
    alias d='fasd -d'
    alias f='fasd -f'
    alias z='fasd_cd -d'
    alias zz='fasd_cd -d -i'
fi

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

# added by pipsi (https://github.com/mitsuhiko/pipsi)
export PATH="${HOME}/.local/bin:$PATH"

