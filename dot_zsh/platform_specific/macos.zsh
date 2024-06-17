if (( $+commands[lsof] )); then
    alias open_ports="lsof -iTCP -sTCP:LISTEN -iUDP -n -P"
fi