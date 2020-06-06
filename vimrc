set nobackup
set nowritebackup
set noswapfile
set tabstop=4
set shiftwidth=4
set si
set number
set hlsearch
set incsearch
set smartcase
set ignorecase
highlight Comment ctermfg=green

set statusline=%F
set nocompatible
syntax enable
filetype plugin on
set path+=**
set wildmenu
set fileencodings=utf-8,cp1251

if !has('nvim')
    if !isdirectory($HOME . "/.local/vim/undo")
        call mkdir($HOME . "/.local/vim/undo", "p", 0700)
    endif
    set undodir=~/.local/vim/undo
endif
set undofile

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END
