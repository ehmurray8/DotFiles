set nocompatible    " not compatible with vi
filetype indent on  " load language specific indents

set foldmethod=syntax
set nofoldenable

set number          " line numbers
set tabstop=4       " 4 spaces for tabs
set shiftwidth=4    " 4 spaces when using ==, <<, >>
set softtabstop=4   " 4 spaces in tab when editing
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

" Remap escape to clear seach highlight
nnoremap <esc> :noh<return><esc>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

inoremap jj <Esc>

" Allow using system clipboard for copy and paste
nnoremap <Leader>y "*y
vnoremap <Leader>y "*y
nnoremap <Leader>p "*p
vnoremap <Leader>p "*p
