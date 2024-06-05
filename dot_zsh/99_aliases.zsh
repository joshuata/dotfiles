alias e="$EDITOR "

alias -s git="git clone"

if (( $+commands[htop] )); then
    alias top="sudo htop"
fi

if (( $+commands[exa] )); then
    alias ls="exa"
fi

if (( $+commands[zoxide] )); then
    alias cd="x"
    alias cdi="xi"
fi

alias tsh="TELEPORT_ADD_KEYS_TO_AGENT=no tsh"
