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

zi pack"binary+keys" for fzf
zi ice wait lucid
zi load chitoku-k/fzf-zsh-completions

zi has'zoxide' wait lucid for atload="function z() { __zoxide_z \"\$@\" }" \
  z-shell/zsh-zoxide

zi ice lucid wait'0'
zi light joshskidmore/zsh-fzf-history-search

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
ZSH_PYENV_QUIET=true

# Completions
zi light felipec/git-completion

zi wait has"brew" pack atload=+"zicompinit; zicdreplay" for brew-completions

zi ice wait lucid blockf
zi load zsh-users/zsh-completions

zi ice wait has"kubectl" lucid
zi snippet OMZP::kubectl

zi ice wait has"op" lucid
zi snippet OMZP::1password

zi ice from"gh" as"program" pick"bin/mdsh"
zi load bashup/mdsh

zi ice has"cargo" lucid nocompile
zi load MenkeTechnologies/zsh-cargo-completion

# Highlighting
zi ice as'null' sbin'bin/*'
zi light z-shell/zsh-diff-so-fancy

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

zi wait lucid for \
  atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions
