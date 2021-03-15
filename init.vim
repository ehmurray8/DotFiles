set nocompatible    " not compatible with vi filetype indent on
set syntax=on

set foldmethod=syntax
set nofoldenable

set number          " line numbers
set tabstop=4       " 4 spaces for tabs
set shiftwidth=4    " 4 spaces when using ==, <<, >> set softtabstop=4   " 4 spaces in tab when editing
set expandtab       " use spaces instead of tabs
set smarttab        " let's tab key insert 'tab stops', and bksp deletes tabs
set shiftround      " tab / shifting moves to closest tabstop.
set autoindent      " match indents on new lines
set smartindent     " intellegently dedent / indent new lines based on rules.

set nobackup        " no file backups
set nowritebackup   " no file backups
set noswapfile      " no swp files

set autoread        " when a file has changed on disk, automatically load it

set undofile        " History mainained after closing file

set ignorecase      " case insensitive search
set smartcase       " case sensitive search if there are uppercase letters
set incsearch       " live incremental searching
set showmatch       " live match highlighting
set gdefault        " use the `g` flag by default.

set virtualedit+=block " allow the cursor to go anywhere in visual block mode.

set cmdheight=2     " Give more space for writing messages for coc
set updatetime=300  " Shorten update time for better performance of coc

set shortmess+=c    " Don't pass messages to |ins-completion-menu|.

set signcolumn=yes  " always show gutter column

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocomplete engine that uses language server
Plug 'kyazdani42/nvim-web-devicons' " Icons library needed for barbar
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' 
Plug 'tpope/vim-surround'           " Supports surroundings, parentheses, brackets, quotes, XML tags, etc.; Usage cs<
Plug 'bling/vim-airline'            " Statusbar
Plug 'w0rp/ale'                     " Asynchronous syntax checker
Plug 'Xuyuanp/nerdtree-git-plugin'  " Git symbols for files in nerdree
Plug 'scrooloose/nerdtree'          " File explorer Ctrl+n
Plug 'Xuyuanp/nerdtree-git-plugin'  " Git symbols for files in nerdree
Plug 'tpope/vim-obsession'          " Easily create sessions with :Obsess
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Show fuzzy finder with Ctrl + t
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'         " Use gc to comment out a block
Plug 'ryanoasis/vim-devicons'       " Icons for nerdtree
Plug 'tpope/vim-fugitive'           " Git plugin
Plug 'tpope/vim-rhubarb'            " Github support for vim fugitive
Plug 'sheerun/vim-polyglot'         " Syntax for most languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'joshdick/onedark.vim'         " Color theme
Plug 'christoomey/vim-tmux-navigator' " Ctrl + hjkl to move between tmux and vim splits, Ctrl + \ to go to last split
Plug 'rhysd/git-messenger.vim'      " Show a popup window of commit at current line with \gm
Plug 'airblade/vim-gitgutter'       " Show git status in gutter with \gg
Plug 'gcmt/taboo.vim'               " Rename tabs
call plug#end()

" Turn off git gutter by default
let g:gitgutter_signs = 0

" Ctrl + t opens fzf file viewer for only git files
map <C-t> :GFiles<CR>

" Ctrl + , renames tab using Taboo
map <C-w>, :TabooRename 

let g:WebDevIconsUnicodeDecorateFolderNodes = 1

set clipboard+=unnamedplus

" Set autopep8 as ale fixer for python
let g:ale_fixers = {'python': ['autopep8'],}

" Remap escape to clear seach highlight
nnoremap <esc> :noh<return><esc>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" jj to escape
inoremap jj <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NerdTree Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle current Nerdtree window
map <C-n> :NERDTreeToggle<CR>

" Have NerdTree open in the last used state
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>

" Toggle all Nerdtree windows
map <Leader>n <plug>NERDTreeTabsToggle<CR>

let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeGitStatusWithFlags = 1

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Allow using system clipboard for copy and paste
nnoremap <Leader>y "*y
vnoremap <Leader>y "*y
nnoremap <Leader>p "*p
vnoremap <Leader>p "*p

let g:python_host_prog = '/usr/bin/python'

nmap <Leader>gg :GitGutterSignsToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC Config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-vetur',
  \ 'coc-highlight',
  \ 'coc-css',
  \ ]

" Show the autocomplete window
inoremap <silent><expr> <c-space> coc#refresh()

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set the color scheme
colorscheme onedark
