# Setup prezto modules

zplugin ice svn wait"0" lucid
zplugin snippet PZT::modules/utility

zplugin ice svn wait"0" lucid
zplugin snippet PZT::modules/completion

zplugin ice svn lucid
zplugin snippet PZT::modules/history

zplugin ice wait"0" svn lucid
zplugin snippet PZT::modules/git

zstyle ':prezto:module:prompt' theme 'sorin'

zplugin load mafredri/zsh-async  # dependency
zplugin ice svn silent
zplugin snippet PZT::modules/prompt

# Setup fasd
if (( $+commands[fasd] )); then
    zplugin ice svn wait lucid
    zplugin snippet PZT::modules/fasd
fi

# fzf setup
zplugin ice wait"0" from"gh-r" as"program" lucid
zplugin load junegunn/fzf-bin

zplugin ice svn wait"0" lucid
zplugin snippet OMZ::plugins/fzf

# Auto-sourcing
zplugin ice wait"0" blockf lucid
zplugin load Tarrasch/zsh-autoenv

zplugin ice svn wait"0" lucid
zplugin load iboyperson/pipenv-zsh

# Highlighting
zplugin ice wait"0" atinit"zpcompinit; zpcdreplay" lucid
zplugin load zdharma/fast-syntax-highlighting
