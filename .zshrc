# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
