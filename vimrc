language en_US

nnoremap ; :
noremap <silent> $ g$
noremap <silent> 0 g0
noremap <silent> j gj
noremap <silent> k gk

nnoremap <Space>y "+y
nnoremap <Space>p "+p
vnoremap <Space>y "+y
vnoremap <Space>p "+p

nnoremap <silent> <Space>nn :Lexplore<CR>

syntax off
set autoindent
set autowrite
" set bg=light
set bg=dark
colorscheme default
set cursorline
set expandtab
" set list
set fileencoding=utf-8
set hlsearch
set incsearch
set colorcolumn=80
set ignorecase
set lazyredraw
set modelines=1
set noswapfile
set nowrap
set scrolloff=10
set nowritebackup
set number
set path+=**
set shiftwidth=4
set noshowmode
set showtabline=1
set smartcase
set smartindent
set softtabstop=4
set spelllang=en_us,ru
set splitright
set tabstop=4
set timeoutlen=500
set title
set mouse=

set wildignore+=*/node_modules/*
set wildignore+=*/sdk/*

autocmd FileType c,cpp,java,php,lua,md,typescript,javascript,python autocmd BufWritePre <buffer> %s/\s\+$//e

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view

set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8

