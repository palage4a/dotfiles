setglobal nocompatible
setglobal pastetoggle=<F2>

if has('nvim')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
      silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    set t_Co=256
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1

if has('nvim')
    Plug 'tpope/vim-fugitive'
    Plug 'chrisbra/csv.vim'
    Plug 'sheerun/vim-polyglot'
    "COC
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile && yarn build'}
    Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile && yarn build'}
    Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile && yarn build'}
    Plug 'neoclide/coc-emmet', {'do': 'yarn install --frozen-lockfile && yarn build'}
    Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile && yarn build'}
    Plug 'neoclide/coc-stylelint', {'do': 'yarn install --frozen-lockfile && yarn build'}
    Plug 'neoclide/coc-vimlsp', {'do': 'yarn install --frozen-lockfile && yarn build'}
    Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile && yarn build'}
    Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile && yarn build'}
    Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile && yarn build'}
    Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile && yarn build'}
    Plug 'coc-extensions/coc-svelte', {'do': 'yarn install --frozen-lockfile && yarn build'}
    Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile && yarn build'}
    Plug 'iamcco/coc-diagnostic', {'do': 'yarn install --frozen-lockfile && yarn build'}
    Plug 'marlonfan/coc-phpls', {'do': 'yarn install --frozen-lockfile && yarn build'}
endif
call plug#end()
colorscheme dracula
let mapleader = "\<space>"
nmap <leader><leader> :NERDTreeToggle<CR>
if has('nvim')
    "COC-RELATED CONFIG
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
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
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
    command! -nargs=0 Format :call CocAction('format')
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
    "" MAPPINGS
    " COC LISTS
    nnoremap <silent> <leader>co  :<C-u>CocList -A outline<CR>
    nnoremap <silent> <leader>cs  :<C-u>CocList -I -A symbols<CR>
    nnoremap <silent> <leader>ca  :<C-u>CocList -A diagnostics<CR>
    nnoremap <silent> <leader>cb  :<C-u>CocList -A diagnostics --current-buf<CR>
    nnoremap <silent> <leader>cc  :<C-u>CocList commands<CR>
    nnoremap <silent> <leader>ce  :<C-u>CocList extensions<CR>
    nnoremap <silent> <leader>cl  :<C-u>CocList location<CR>
    nnoremap <silent> <leader>cS  :<C-u>CocList services<CR>
    nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>
    set shortmess+=c
    set inccommand=split
    set signcolumn=yes
    " set termguicolors
    " TERMINAL REG ENABLE
    tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
else
	let g:fzf_preview_window = ''
endif
"
" FZF
nnoremap <silent> <leader>ff  :GitFiles<CR>
nnoremap <silent> <leader>fg  :Files<CR>
nnoremap <silent> <leader>ft  :Filetypes<CR>
nnoremap <silent> <leader>fb  :Buffers<CR>
nnoremap <silent> <leader>fc  :Commands<CR>
nnoremap <silent> <leader>fm  :Maps<CR>
nnoremap <silent> <leader>fw  :Windows<CR>
nnoremap <silent> <leader>fq  :History:<CR>
" GIT
nnoremap <silent> <leader>gg :G<CR>
"RG
nnoremap <silent> <leader>rw  :Rg <C-r><C-w><CR>
nnoremap <silent> <leader>rr  :Rg<CR>
nnoremap <silent> <leader>r'  :Rg<CR>'

nmap j gj
nmap k gk

set hidden
set number
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set timeoutlen=1000 
set ttimeoutlen=0
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
set noundofile

syntax enable
filetype plugin on
set path=**
set wildmenu
set fileencodings=utf-8,cp1251
set undofile
set wrap
set magic
set mouse=a
