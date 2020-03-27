fpath+=~/.zfunc

### Set zsh options
setopt auto_cd
setopt promptsubst

### Initialize zinit
# Load
source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load plugins
source "${HOME}/.zsh/plugins.zsh"
### End of block

DEFAULT_USER=joshuata

alias e="$EDITOR "


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

