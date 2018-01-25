let mapleader = "\<space>"
nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>p :CtrlP<CR>

set pastetoggle=<F2>

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
