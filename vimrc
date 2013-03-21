"|
"| File          : ~/.vimrc
"| Last modified : 2013-01-03
"| Author        : Fabien Cazenave
"| Licence       : WTFPL
"|

" source configuration files on save to apply all changes immediately
autocmd! BufWritePost vimrc         source $MYVIMRC
autocmd! BufWritePost .vimrc        source $MYVIMRC
autocmd! BufWritePost _vimrc        source $MYVIMRC
autocmd! BufWritePost Xresources    !xrdb -load ~/.Xresources
autocmd! BufWritePost .Xresources   !xrdb -load ~/.Xresources
autocmd! BufWritePost tmux.conf     !tmux source-file ~/.tmux.conf
autocmd! BufWritePost .tmux.conf    !tmux source-file ~/.tmux.conf
autocmd! BufWritePost gtkrc         !gtkrc-reload
autocmd! BufWritePost gtkrc-2.0     !gtkrc-reload
autocmd! BufWritePost .gtkrc-2.0    !gtkrc-reload

" everytime we change window, check if file has been updated outside of the editor
autocmd WinEnter * checktime

" Modern / standard / Notepad-like behavior:
" load "mwwin.vim" or "notepad.vim" <https://github.com/fabi1cazenave/gnupad>
"source $VIMRUNTIME/mswin.vim
"behave mswin " ???
set nocompatible   " required for a multi-level undo/redo stack
set mouse=a        " enable mouse selection


"|=============================================================================
"|    Plugins                                                               <<<
"|=============================================================================

filetype off       " required!
source ~/.vim/plugins.vim
filetype plugin indent on

" if exists("Ranger")
  noremap <silent> <Esc>e :call Ranger()<CR>
" endif

">>>

"|=============================================================================
"|    Mappings                                                              <<<
"|=============================================================================

" disable digraph input to make <^> work faster
set nodigraph
set encoding=utf-8

" make Y copy to the end of the line (more consistant with D, C, etc.)
map Y y$

" the Ex mode is useless (except for Vi compatibility), disable it
" map Q <Nop>

" Alternative: use q: instead
nmap Q q:

" U is useless (except for Vi compatibility), make it a redo instead
map U <C-r>

" make K more consistent with J (J = join, K = split)
nnoremap K i<CR><Esc>k$

" Alternative: use a real 'Man' on K
" runtime ftplugin/man.vim
" nnoremap K :Man <C-r><C-w><CR>

" indexes the last search
nmap g/ :vimgrep /<C-r>//j %<Bar>cw<CR>

" use :W to sudo-write the current buffer
command! W w !sudo tee % > /dev/null

" Enter as leader key
" let mapleader = "\<Enter>"

" Alternative: Space as leader key
" nmap <Space> <Nop>
" let mapleader = "\<Space>"

" Alternative: Space/BackSpace for Page Down/Up
noremap <BS> <PageUp>
noremap <Space> <PageDown>
noremap <C-j> <C-y>
noremap <C-k> <C-e>
" noremap <S-BS> <C-u>
" noremap <S-Space> <C-d>
" noremap   <C-d>
" noremap <S-BS> <C-y>
" noremap <S-Space> <C-e>
" noremap   <C-e>

" Opens a vertical split and switches over (v)
nnoremap <leader>v <C-w>v<C-w>l
nnoremap ŭ <C-w>v<C-w>l

source ~/.vim/mappings.vim
">>>

"|=============================================================================
"|    Terminal                                                              <<<
"|=============================================================================

set shell=/usr/bin/zsh
set t_Co=256 " because all terms should support 256 colors nowadays…
set title

" send the current filename to GNU Screen / tmux
"if (&term == 'screen') || (&term == 'screen-bce') || (&term == 'screen-color')
"  exe "set title titlestring=Vim:%f"
"  exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
"endif

" GNU screen
"http://www.semicomplete.com/blog/productivity/39.html
"map <M-v>  :silent !screen -X split<CR>:silent !screen -X focus down<CR>:silent !screen -X screen /home/kaze/.vim/screener.sh<CR>:redraw!<CR>
"map <Esc>v :silent !screen -X split<CR>:silent !screen -X focus down<CR>:silent !screen -X screen /home/kaze/.vim/screener.sh<CR>:redraw!<CR>

">>>

"|=============================================================================
"|    User Interface                                                        <<<
"|=============================================================================

set showmode
set cursorline
set showfulltag
set ruler
set laststatus=2 " always show statusline

"set guioptions=reTm
"set guifont=Monospace\ 9
"colorscheme desert
set guioptions=
set guifont=Ubuntu\ Mono\ 11
colorscheme kalahari        " https://github.com/fabi1cazenave/kalahari.vim
syntax on

"http://vim.wikia.com/wiki/Fix_syntax_highlighting
"autocmd BufEnter * :syntax sync fromstart

set showtabline=2           " show tabbar even for a single buffer

" show tabs / nbsp / trailing spaces
"set listchars=tab:▶\ ,trail:◀,extends:»,precedes:«
"set listchars=nbsp:¤,tab:>·,trail:¤,extends:>,precedes:<
set listchars=nbsp:¤,tab:··,trail:¤,extends:>,precedes:<
set list

" split windows below the current window.
set splitbelow

">>>

"|=============================================================================
"|    General settings                                                      <<<
"|=============================================================================

" this is supposed to improve terminal emulation greatly (?)
set guipty
"set visualbell

" this should be the default but some distros disable modelines by default...
set modeline
set modelines=5

" text display
set number          	" set nu
"set relativenumber  	" set rnu
set scrolloff=5     	" number of screen lines to show around the cursor
set nuw=6           	" number width (not working?)
set showmatch       	" when inserting a bracket, briefly jump to its match
"set filetype=vim    	" trigger the FileType event when set (local to buffer)

" use the current file's directory as Vim's working directory
set autochdir       	" XXX not working on MacOSX

" don't create backupfiles everywhere, but just in ~/.vim/backup
set backupdir=~/.vim/backup
set dir=~/.vim/backup

" persistent undo
set undofile
set undodir=~/.vim/undodir

" 80-character lines (= Mozilla guidelines)
set colorcolumn=+0
set textwidth=80    	" line length above which to break a line
set nowrap
"set nowrapscan
set linebreak

" two-space indentation (= Mozilla guidelines), except for makefiles
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set cindent
set smartindent
"set autoindent
autocmd FileType ?akefile set noexpandtab
"set foldmethod=indent
autocmd FileType html,xhtml,javascript,css,c,cpp,python setlocal foldmethod=indent

" search settings
set hlsearch        	" highlight search results
set incsearch       	" incremental search: find as you type
set ignorecase      	" search is case-insensitive…
set smartcase       	" … except if the search pattern contains uppercase chars

" http://stackoverflow.com/questions/1551231/highlight-variable-under-cursor-in-vim-like-in-netbeans
" autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
" autocmd CursorMoved * exe printf('match ColorColumn /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" case-insensitive tab completion
set wildmode=longest:list
if exists("&wildignorecase")
  set wildignorecase
endif

" disable incrementation of octal numbers
set nrformats=hex

" enable easier rectangular selections
set virtualedit=block

" set matchpairs+=<:>

">>>

" vim: set fdm=marker fmr=<<<,>>> fdl=0:
