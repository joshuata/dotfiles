# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias e="$EDITOR "

alias -s git="git clone"

if (( $+commands[nvim] )); then
    alias vim='nvim'
fi

if (( $+commands[htop] )); then
    alias top="sudo htop"
fi

if (( $+commands[exa] )); then
    alias ls="exa"
fi

# if (( $+commands[fasd] )); then
#     alias j='fasd_cd -d'
#     alias a='fasd -a'
#     alias s='fasd -si'
#     alias sd='fasd -sid'
#     alias sf='fasd -sif'
#     alias d='fasd -d'
#     alias f='fasd -f'
#     alias z='fasd_cd -d'
#     alias zz='fasd_cd -d -i'
# fi
