"Syntax
set nocompatible
syntax enable
filetype plugin on

"Fuzzy finding
set path+=**
set wildmenu

" Tags
command! MakeTags !ctags -R .

" Explorer setting
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup
set nowb
set noswapfile

set tabstop=2
set shiftwidth=2
set expandtab
set si
set number
set hlsearch
set incsearch
set ruler
highlight Comment ctermfg=green

set laststatus=2
set statusline=%F
