"|
"| File    : ~/.vimrc
"| Source  : https://github.com/fabi1cazenave/dotFiles
"| Licence : WTFPL
"|

let $VIMHOME = glob('~/.vim')   	" user directory
let $VIMTEMP = glob('~/.vim/tmp')	" temp directory

" don’t create temp files everywhere, but just in $VIMTEMP if it exists
if !empty($VIMTEMP)             	" check that the directory exists
  set backupdir=$VIMTEMP        	" backup files
  set directory=$VIMTEMP        	" swap files
  set undodir  =$VIMTEMP        	" undo files
  set undofile                  	" persistent undo
endif

" two solutions to let CTRL-ZXCV behave like in Notepad:
"  * the standard "mswin.vim" resource: source $VIMRUNTIME/mswin.vim
"  * the "cua-mode.vim" plugin: https://github.com/fabi1cazenave/cua-mode.vim
" (the CUA mode, by default, preserves other Vim shortcuts much better)

" modern behavior
set nocompatible                	" required for a multi-level undo/redo stack
set mouse=a                     	" enable mouse selection


"|=============================================================================
"|    Auto-reload configuration files                                       <<<
"|=============================================================================

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

"http://vim.wikia.com/wiki/Fix_syntax_highlighting
"autocmd BufEnter * :syntax sync fromstart
">>>

"|=============================================================================
"|    Plugins                                                               <<<
"|=============================================================================

filetype off       " required!

if filereadable($VIMHOME.'/plugins.vim')
  source $VIMHOME/plugins.vim
endif

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

" Enter to follow tags (e.g. help links)
noremap <Enter> <C-]>

" other specific mappings
if filereadable($VIMHOME.'/mappings.vim')
  source $VIMHOME/mappings.vim
endif
">>>

"|=============================================================================
"|    Terminal                                                              <<<
"|=============================================================================

set shell=/usr/bin/zsh
set t_Co=256          	" because all terms should support 256 colors nowadays…
set notitle           	" don’t set the title to “Thanks for flying vim” on exit
set guipty            	" better (?) terminal emulation in GUI mode

" handle screen / tmux
if &term =~ '^screen'
  " proper italics (≠ standout)
  set t_so=[7m      	" warning: ^[ must be entered as <C-v><C-[>
  set t_ZH=[3m
  " send the current filename to screen / tmux
  " exe "set title titlestring=Vim:%f"
  " exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
endif
">>>

"|=============================================================================
"|    User Interface                                                        <<<
"|=============================================================================
"set visualbell

set showmode          	" display current mode blow the status line
set showtabline=2     	" show tabbar even for a single buffer
set laststatus=2      	" always show the status line
set ruler             	" display line/col position in the status line
set cursorline        	" highlight current line
set splitbelow        	" consistency with most tiling WMs (wmii, i3…)
set virtualedit=block 	" easier rectangular selections

" line numbers
set number            	" show absolute line numbers (:set nu)
"set relativenumber    	" show relative line numbers (:set rnu)
set scrolloff=5       	" number of screen lines to show around the cursor
set numberwidth=6     	" minimal number width (not working?)

" show tabs / nbsp / trailing spaces
set listchars=nbsp:¤,tab:··,trail:¤,extends:>,precedes:<
set list

" minimal interface when running in GUI mode
set guioptions=
set guifont=Inconsolata\ 11

" syntax highlighting
colorscheme kalahari  	" https://github.com/fabi1cazenave/kalahari.vim
syntax on
">>>

"|=============================================================================
"|    General settings                                                      <<<
"|=============================================================================

set encoding=utf-8

" this should be the default but some distros disable modelines by default…
set modeline
set modelines=5

" use the current file’s directory as Vim’s working directory
set autochdir         	" XXX not working on MacOSX

set showmatch         	" when inserting a bracket, briefly jump to its match
"set filetype=vim      	" trigger the FileType event when set (local to buffer)

" 80-character lines (= Mozilla guidelines)
set textwidth=80      	" line length above which to break a line
set colorcolumn=+0    	" highlight the textwidth limit
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
set showfulltag

" disable incrementation of octal numbers
set nrformats=hex

" set matchpairs+=<:>
">>>

" vim: set fdm=marker fmr=<<<,>>> fdl=0:
