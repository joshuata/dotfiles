alias -s git="git clone"

if (( $+commands[lsof] )); then
    alias open_ports="lsof -iTCP -sTCP:LISTEN -iUDP -n -P"
fi

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

eval "$(fnox activate zsh)"