call plug#begin("$XDG_DATA_HOME/vim/plugged")

Plug 'alker0/chezmoi.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'sgur/vim-editorconfig'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Tmux interaction
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'

" UI plugins
Plug 'nathanaelkane/vim-indent-guides'
Plug 'altercation/vim-colors-solarized'
Plug 'iCyMind/NeoSolarized'

" Language Specific
Plug 'cespare/vim-toml'
Plug 'kris2k/a.vim'
Plug 'rhysd/vim-clang-format'

call plug#end()
