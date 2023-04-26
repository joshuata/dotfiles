zi light z-shell/z-a-bin-gem-node
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

zi ice from"gh-r" as"program"
zi load junegunn/fzf-bin

export FZF_BASE="$HOME/.zi/plugins/junegunn---fzf-bin/"
export DISABLE_FZF_KEY_BINDINGS="true"

zi ice wait lucid
zi load chitoku-k/fzf-zsh-completions

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
zi ice lucid
zi from"gh-r" as"program" mv"direnv* -> direnv" \
  atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
  pick"direnv" src="zhook.zsh" for \
    direnv/direnv

zi ice wait has"poetry" lucid
zi load darvid/zsh-poetry

zi ice wait lucid
zi snippet OMZP::pyenv

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

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
