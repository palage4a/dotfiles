setglobal nocompatible
setglobal pastetoggle=<F2>

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'chrisbra/NrrwRgn'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'kkoomen/vim-doge'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/csv.vim'
Plug 'skanehira/docker-compose.vim'
Plug 'sheerun/vim-polyglot'
Plug 'voldikss/vim-floaterm'


Plug 'antoinemadec/coc-fzf'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}

" REFACTOR
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-emmet', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-stylelint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}

Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}
Plug 'coc-extensions/coc-svelte', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-diagnostic', {'do': 'yarn install --frozen-lockfile'}
Plug 'marlonfan/coc-phpls', {'do': 'yarn install --frozen-lockfile'}

call plug#end()
set termguicolors     " enable true colors support

set background=dark
colorscheme gruvbox
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = "unique_tail_improved"
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = '1'

let mapleader = "\<space>"
nmap <leader><leader> :NERDTreeToggle<CR>
set hidden
set number
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set timeoutlen=1000 
set ttimeoutlen=0
set shortmess+=c
set signcolumn=yes
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')


xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocAction('format')

command! -nargs=? Fold :call     CocAction('fold', <f-args>)

command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" COC FZF
nnoremap <silent> <leader>ca  :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> <leader>cb  :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <leader>cc  :<C-u>CocFzfList commands<CR>
nnoremap <silent> <leader>ce  :<C-u>CocFzfList extensions<CR>
nnoremap <silent> <leader>cl  :<C-u>CocFzfList location<CR>
nnoremap <silent> <leader>co  :<C-u>CocFzfList outline<CR>
nnoremap <silent> <leader>cs  :<C-u>CocFzfList symbols<CR>
nnoremap <silent> <leader>cS  :<C-u>CocFzfList services<CR>
nnoremap <silent> <leader>cp  :<C-u>CocFzfListResume<CR>

" FZF
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
nnoremap <silent> <leader>ff  :GitFiles<CR>
nnoremap <silent> <leader>fg  :Files<CR>
nnoremap <silent> <leader>fT  :Filetypes<CR>
nnoremap <silent> <leader>ft  :Tags<CR>
nnoremap <silent> <leader>fb  :Buffers<CR>
nnoremap <silent> <leader>fc  :Commands<CR>
nnoremap <silent> <leader>fw  :Windows<CR>

" GIT
nnoremap <silent> <leader>gg :G<CR>

" TERMINAL
noremap  <leader>//  :FloatermToggle<CR>
noremap  <leader>/c  :FloatermNew<CR>
noremap  <leader>/n  :FloatermNext<CR>
noremap  <leader>/p  :FloatermPrev<CR>
noremap! <leader>/t <Esc>:FloatermToggle<CR>
tnoremap <leader>/t <C-\><C-n>:FloatermToggle<CR>

"RG
nnoremap <silent> <leader>rw  :Rg <C-r><C-w><CR>
nnoremap <silent> <leader>rr  :Rg<CR>
vnoremap <silent> <leader>rv  y:Rg <C-f>p<CR>

nnoremap <silent> <leader>n  :bn<CR>
nnoremap <silent> <leader>p  :bp<CR>

nnoremap <silent> <leader>rc  :source ~/.config/nvim/init.vim<CR>
nnoremap <silent> //  :nohls<CR>

nnoremap <silent> <leader>\  :vsp<CR>
nnoremap <silent> <leader>-  :sp<CR>
nnoremap ; :
tnoremap jj <C-\><C-n>

set nobackup
set nowritebackup
set noswapfile
set tabstop=4
set shiftwidth=4
set expandtab
set si
set number
set hlsearch
set incsearch
set smartcase
set ignorecase

" set statusline=%F
syntax enable
filetype plugin on
set path+=**
set wildmenu
set fileencodings=utf-8,cp1251
set undofile
set nowrap
set magic
set mouse=a

" example for addition comment functional to undefined filetype
" autocmd FileType apache setlocal commentstring=#\ %s<Paste>
" autocmd FileType apache setlocal commentstring=#\ %s<Paste>
autocmd BufRead,BufNewFile *.vue setfiletype vue
