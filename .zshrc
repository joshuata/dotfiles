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

if type fasd > /dev/null 2>&1; then
    function fasd_cd() {
        if [ $# -le 1 ]; then
            fasd "$@"
        else
            local _fasd_ret="$(fasd -e 'printf %s' "$@")"
            [ -z "$_fasd_ret" ] && return
            [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s\n "$_fasd_ret"
        fi
    }

    alias a='fasd -a'
    alias s='fasd -si'
    alias sd='fasd -sid'
    alias sf='fasd -sif'
    alias d='fasd -d'
    alias f='fasd -f'
    alias z='fasd_cd -d'
    alias zz='fasd_cd -d -i'
fi

# added by pipsi (https://github.com/mitsuhiko/pipsi)
export PATH="/Users/joshuata/.local/bin:$PATH"
