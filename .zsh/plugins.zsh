# Setup prezto utility modules

zinit ice lucid
zinit snippet PZT::modules/helper/init.zsh

zinit ice lucid
zinit snippet PZT::modules/utility/init.zsh

zinit ice lucid
zinit snippet PZT::modules/history/init.zsh

# Prompt setup
zinit ice lucid
zinit snippet OMZ::lib/theme-and-appearance.zsh

zinit ice lucid
zinit snippet OMZ::lib/git.zsh

zinit ice wait lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh

# ZSH_THEME="sorin"
PS1=">"
zinit ice lucid
zinit snippet OMZ::themes/sunrise.zsh-theme

# Setup fasd and fzf
ZSH_CACHE_DIR="$HOME/.zsh/cache"
zinit ice wait lucid
zinit snippet OMZ::plugins/fasd/fasd.plugin.zsh

zinit ice wait has"fzf" lucid
zinit snippet OMZ::plugins/fzf/fzf.plugin.zsh

FZFZ_RECENT_DIRS_TOOL=fasd
zinit ice wait has"fzf" blockf lucid
zinit load andrewferrier/fzf-z

# iTerm handling
zinit ice wait"0" lucid
zinit snippet OMZ::plugins/iterm2/iterm2.plugin.zsh

zinit ice lucid
zinit snippet https://iterm2.com/shell_integration/zsh

# Auto-sourcing
zinit ice wait"0" blockf lucid
zinit load Tarrasch/zsh-autoenv

zinit ice wait"0" lucid
zinit load iboyperson/pipenv-zsh

# Completions
zinit ice wait"0" lucid blockf
zinit load zsh-users/zsh-completions

zinit ice wait"0" lucid blockf
zinit snippet PZT::modules/completion/init.zsh

zinit ice wait has"docker" as"completion" lucid
zinit snippet OMZ::plugins/docker/_docker

zinit ice wait has"docker-compose" as"completion" lucid
zinit snippet OMZ::plugins/docker-compose/_docker-compose

# Highlighting
zinit ice wait"0" atinit"zpcompinit; zpcdreplay" lucid
zinit load zdharma/fast-syntax-highlighting
