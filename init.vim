set nocompatible    " not compatible with vi
filetype indent on  " load language specific indents

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

set ignorecase      " case insensitive search
set smartcase       " case sensitive search if there are uppercase letters
set incsearch       " live incremental searching
set showmatch       " live match highlighting
set gdefault        " use the `g` flag by default.

set virtualedit+=block " allow the cursor to go anywhere in visual block mode.

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'           " Supports surroundings, parentheses, brackets, quotes, XML tags, etc.
Plug 'scrooloose/nerdtree'          " File explorer Ctrl+n
Plug 'bling/vim-airline'            " Statusbar
Plug 'w0rp/ale'                     " Asynchronous syntax checker
Plug 'Xuyuanp/nerdtree-git-plugin'  " Git symbols for files in nerdree
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }  " Autocomplete engine
Plug 'jistr/vim-nerdtree-tabs'      " Names Nerdtree tabs
Plug 'tpope/vim-obsession'          " Easily create sessions with :Obsess
call plug#end()

" Start deoplete at startup
let g:deoplete#enable_at_startup = 1

" Close deoplete when done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


" NERD Tree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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

" Toggle all Nerdtree windows
map <Leader>n <plug>NERDTreeTabsToggle<CR>
" Toggle current Nerdtree window
map <C-n> :NERDTreeToggle<CR>

" Allow using system clipboard for copy and paste
nnoremap <Leader>y "*y
vnoremap <Leader>y "*y
nnoremap <Leader>p "*p
vnoremap <Leader>p "*p

" Toggle deoplete syntax highlighting
nnoremap <Leader>d :call deoplete#toggle()<CR>
