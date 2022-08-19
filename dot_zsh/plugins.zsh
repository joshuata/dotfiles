zi light z-shell/z-a-patch-dl

# Setup prezto utility modules

zi ice lucid
zi snippet PZT::modules/helper/init.zsh

zi ice lucid
zi snippet PZT::modules/utility/init.zsh

zi ice lucid
zi snippet PZT::modules/history/init.zsh

zi ice depth=1
zi load romkatv/powerlevel10k

# Setup fasd and fzf
ZSH_CACHE_DIR="$HOME/.zsh/cache"
zi ice wait lucid
zi snippet OMZ::plugins/fasd/fasd.plugin.zsh

zi pack"bgn-binary" for fzf

zi ice wait has"fzf" lucid
zi snippet OMZ::plugins/fzf/fzf.plugin.zsh

FZFZ_RECENT_DIRS_TOOL=fasd
zi ice wait has"fzf" blockf lucid
zi load andrewferrier/fzf-z

# iTerm handling
zi ice wait lucid
zi snippet OMZ::plugins/iterm2/iterm2.plugin.zsh

zi ice lucid
zi snippet https://iterm2.com/shell_integration/zsh

# Auto-sourcing
zi ice wait blockf lucid
zi load Tarrasch/zsh-autoenv

zi ice wait lucid
zi load darvid/zsh-poetry

# Completions
zi ice wait lucid blockf
zi load zsh-users/zsh-completions

zi ice wait lucid blockf
zi snippet PZT::modules/completion/init.zsh

zi ice wait has"docker" as"completion" lucid
zi snippet OMZ::plugins/docker/_docker

zi ice wait has"docker-compose" as"completion" lucid
zi snippet OMZ::plugins/docker-compose/_docker-compose

zi ice wait has"op" lucid
zi snippet OMZ::plugins/1password/1password.plugin.zsh

# Highlighting
zi ice wait atinit"zpcompinit; zpcdreplay" lucid
zi load zdharma/fast-syntax-highlighting
