set nocompatible    " not compatible with vi filetype indent on set syntax=on

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

" This was causing errors
" https://www.reddit.com/r/neovim/comments/lxu7p3/error_incompatible_undo_file_whenever_i_open_a/
" set undofile        " History mainained after closing file

set ignorecase      " case insensitive search
set smartcase       " case sensitive search if there are uppercase letters
set incsearch       " live incremental searching
set showmatch       " live match highlighting
set gdefault        " use the `g` flag by default.

set virtualedit+=block " allow the cursor to go anywhere in visual block mode.

set cmdheight=2     " Give more space for writing messages for coc
set updatetime=300  " Shorten update time for better performance of coc

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'bling/vim-airline'            " Statusbar
Plug 'Xuyuanp/nerdtree-git-plugin'  " Git symbols for files in nerdree
Plug 'scrooloose/nerdtree'          " File explorer Ctrl+n
Plug 'Xuyuanp/nerdtree-git-plugin'  " Git symbols for files in nerdree
Plug 'tpope/vim-commentary'         " Use gc to comment out a block
Plug 'tpope/vim-fugitive'           " Git plugin
Plug 'tpope/vim-rhubarb'            " Github support for vim fugitive
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'joshdick/onedark.vim'         " Color theme
Plug 'christoomey/vim-tmux-navigator' " Ctrl + hjkl to move between tmux and vim splits, Ctrl + \ to go to last split
Plug 'rhysd/git-messenger.vim'      " Show a popup window of commit at current line with \gm
Plug 'airblade/vim-gitgutter'       " Show git status in gutter with \gg
Plug 'nvim-lua/plenary.nvim'        " Async utilities required for telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' } " Fuzzy finder
Plug 'neovim/nvim-lspconfig'        " Language server for neovim
Plug 'williamboman/mason.nvim'      " Easily install and manage LSP servers, DAP servers, linters, and formatters.
Plug 'williamboman/mason-lspconfig.nvim' " Connects mason and lsp-config
Plug 'folke/neodev.nvim'            " Uses the lua language server for neovim config
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }                         " Improve performance of telescope, https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies
call plug#end()

" Turn off git gutter by default
let g:gitgutter_signs = 0

" Ctrl + t opens fzf file viewer for only git files
map <C-t> :GFiles<CR>

" Ctrl + , renames tab using Taboo
map <C-w>, :TabooRename 

let g:WebDevIconsUnicodeDecorateFolderNodes = 1

set clipboard+=unnamedplus

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" jj to escape
inoremap jj <Esc>

" Allow using system clipboard for copy and paste
nnoremap <Leader>y "*y
vnoremap <Leader>y "*y
nnoremap <Leader>p "*p
vnoremap <Leader>p "*p

nmap <Leader>gg :GitGutterSignsToggle<CR>

" Set the color scheme
colorscheme onedark

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
