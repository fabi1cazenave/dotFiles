"|
"| File          : ~/.vimrc
"| Last modified : 2013-01-03
"| Author        : Fabien Cazenave
"| Licence       : WTFPL
"| vim           : set fdm=marker:fmr=<<<,>>>:fdl=0:
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
set nocompatible   " required for a multi-level undo/redo stack
set mouse=a        " enable mouse selection


"|============================================================================
"|    Plugins                                                              <<<
"|============================================================================

source ~/.vim/plugins.vim
">>>

"|============================================================================
"|    Mappings                                                             <<<
"|============================================================================

" disable digraph input to make <^> work faster
set nodigraph
set encoding=utf-8

let mapleader = ","
" alternative: use <Space> as <Leader>
"let mapleader = "°"
"map <Space> °

" Make Y copy to the end of the line (more consistant with D, C, etc.)
"map Y y$"
map Y y$

" lazy scrolling
noremap <BS> <PageUp>
noremap <Space> <PageDown>
"noremap <S-BS> <C-u>
"noremap <S-Space> <C-d>

source ~/.vim/mappings.vim
">>>

"|============================================================================
"|    Terminal                                                             <<<
"|============================================================================

"set shell=/bin/zsh
set t_Co=256 " because all terms should support 256 colors nowadays…
set title

" send the current filename to GNU Screen / tmux
"if (&term == 'screen') || (&term == 'screen-bce') || (&term == 'screen-color')
  "exe "set title titlestring=Vim:%f"
  "exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
"endif

" GNU screen
"http://www.semicomplete.com/blog/productivity/39.html
"map <M-v>  :silent !screen -X split<CR>:silent !screen -X focus down<CR>:silent !screen -X screen /home/kaze/.vim/screener.sh<CR>:redraw!<CR>
"map <Esc>v :silent !screen -X split<CR>:silent !screen -X focus down<CR>:silent !screen -X screen /home/kaze/.vim/screener.sh<CR>:redraw!<CR>

">>>

"|============================================================================
"|    User Interface                                                       <<<
"|============================================================================

"behave mswin " ???
set showmode
set cursorline
set showfulltag
set ruler
"set laststatus=2 " always show statusline

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
">>>

"|============================================================================
"|    General settings                                                     <<<
"|============================================================================

" this is supposed to improve terminal emulation greatly (?)
set guipty
set modelines=0
"set visualbell

" text display
set number          	" set nu
"set relativenumber  	" set rnu
"set scrolloff=5     	" number of screen lines to show around the cursor
set nuw=6           	" fixed number width (not working?)
set showmatch       	" when inserting a bracket, briefly jump to its match
"set filetype=vim    	" triggers the FileType event when set (local to buffer)

" use the current file's directory as Vim's working directory
set autochdir       	" XXX not working on MacOSX

" don't create backupfiles everywhere, but just in ~/.vim/backup
set backupdir=~/.vim/backup
set dir=~/.vim/backup

" persistent undo
set undofile
set undodir=~/.vim/undodir

" 80-character lines (= Mozilla guidelines)
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

" case-insensitive tab completion
set wildmode=longest:list
if exists("&wildignorecase")
  set wildignorecase
endif

" disable incrementation of octal numbers
set nrformats=hex

" imported Zenwalk settings
"set updatecount=0   	" number of characters typed to cause a swap file update
"set backspace=2     	" <BackSpace> behavior in Insert mode

"set confirm         	" ???

">>>

