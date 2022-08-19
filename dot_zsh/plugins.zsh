zi light z-shell/z-a-patch-dl

# Setup prezto utility modules

zi ice lucid
zi snippet PZTM::helper

zi ice lucid
zi snippet PZTM::utility

zi ice lucid
zi snippet PZTM::history

zi ice depth=1
zi load romkatv/powerlevel10k

# Setup fasd and fzf
ZSH_CACHE_DIR="$HOME/.zsh/cache"
zi ice wait lucid
zi snippet OMZP::fasd

zi pack"bgn-binary" for fzf

zi ice wait has"fzf" lucid
zi snippet OMZP::fzf

FZFZ_RECENT_DIRS_TOOL=fasd
zi ice wait has"fzf" blockf lucid
zi load andrewferrier/fzf-z

zi ice wait has"aws" lucid
zi snippet OMZP::aws

# iTerm handling
zi ice wait lucid
zi snippet OMZP::iterm2

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
zi snippet PZTM::completion

zi ice wait has"docker" lucid
zi snippet OMZP::docker

zi ice wait has"op" lucid
zi snippet OMZP::1password

# Highlighting
zi ice wait atinit"zpcompinit; zpcdreplay" lucid
zi load zdharma/fast-syntax-highlighting
