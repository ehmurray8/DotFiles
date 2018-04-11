set nocompatible " Don't be compatible with vi
filetype indent on " Load language specific indents

set number " line numbers
set tabstop=4 " 4 spaces for tabs
set shiftwidth=4 
set softtabstop=4 " 4 spaces in tab when editing
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent " Match indents on new lines.
set smartindent " Intellegently dedent / indent new lines based on rules.


" We have VCS -- we don't need this stuff.
set nobackup " We have vcs, we don't need backups.
set nowritebackup " We have vcs, we don't need backups.
set noswapfile " They're just annoying. Who likes them?

" don't nag me when hiding buffers
set hidden " allow me to have buffers with unsaved changes.
set autoread " when a file has changed on disk, just load it. Don't ask.

" Make search more sane
set ignorecase " case insensitive search
set smartcase " If there are uppercase letters, become case-sensitive.
set incsearch " live incremental searching
set showmatch " live match highlighting
set gdefault " use the `g` flag by default.

" allow the cursor to go anywhere in visual block mode.
set virtualedit+=block


" NERD Tree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Fugitive Vim
autocmd QuickFixCmdPost *grep* cwindow

set clipboard+=unnamedplus


" Key mappings
inoremap jj <Esc>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

nnoremap <leader><space> :nohlsearch<CR> " turn off search highlight

nnoremap <Leader>y "*y
vnoremap <Leader>y "*y
nnoremap <Leader>p "*p
vnoremap <Leader>p "*p

nnoremap <C-m> :SyntasticToggleMode<Return>
vnoremap <C-m> :SyntasticToggleMode<Return>
