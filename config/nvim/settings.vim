"|
"| File    : ~/.config/nvim/settings.vim
"| Author  : Fabien Cazenave
"| Source  : https://github.com/fabi1cazenave/dotFiles
"| Licence : WTFPL
"|

set termguicolors " 24bit colors, baby!
set winblend=20   " Neovim 0.4+ pseudo-transparency for floating windows <3
set mouse=a
set updatetime=300
set winminheight=0

" TupperVim:
" sudo sysctl vm.swappiness=0
" see https://askubuntu.com/questions/235146/why-does-ubuntu-use-swap-when-there-is-enough-free-memory

" TupperVim: change the curent indentation size
" :set ts=4 sts=4 noet
" :retab!
" :set ts=2 sts=2 et
" :retab

"|    General settings                                                      {{{
"|-----------------------------------------------------------------------------

"set encoding=utf-8

" this should be the default but some distros disable modelines by default…
set modeline
set modelines=5

" use the current file’s directory as Vim’s working directory
" Alternative: 'airblaide/vim-rooter'
"set autochdir       	" XXX not working on MacOSX

set showmatch       	" when inserting a bracket, briefly jump to its match
"set filetype=vim    	" trigger the FileType event when set (local to buffer)

" 80-character lines (= Mozilla guidelines)
set textwidth=80    	" line length above which to break a line
set colorcolumn=+0  	" highlight the textwidth limit
set nowrap
set linebreak

" search settings
set hlsearch        	" highlight search results
set incsearch       	" incremental search: find as you type
set inccommand=split	" incremental replace: show as you type (in a split)
set ignorecase      	" search is case-insensitive…
set smartcase       	" … except if the search pattern contains uppercase chars
set nowrapscan      	" don’t loop through search results

" case-insensitive tab completion in the command line
set wildmenu        	" enhanced command-line completion in the status line
set wildmode=longest,full " (use `list:longest` to complete files like a shell)
set wildignorecase
set showfulltag
set completeopt=menuone,noinsert,noselect " better completion experience
set shortmess+=c " avoid showing message extra message when using completion

" disable incrementation of octal numbers
set nrformats=hex

" set matchpairs+=<:>
"}}}

"|    Indentation                                                           {{{
"|-----------------------------------------------------------------------------
" two-space indentation everywhere, except for Python and makefiles

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
" set cindent
set smartindent
set shiftround
"set autoindent

" Makefile, Python: tab / 4-space indents
augroup specialIndents
  autocmd FileType ?akefile setlocal noexpandtab
  autocmd FileType python   setlocal expandtab ts=4 sw=4 sts=4
  " autocmd FileType html,xhtml,javascript,css,c,cpp,python setlocal foldmethod=indent
augroup END

" fold on indentation by default, except for these specific file types
set foldmethod=indent
augroup specialFolds
  autocmd FileType help      setlocal foldmethod=marker nonumber nolist
  autocmd FileType vim-plug  setlocal foldmethod=manual nonumber
  autocmd FileType startify  setlocal foldmethod=manual
  autocmd FileType lspinfo   setlocal foldmethod=marker
  autocmd FileType git       setlocal foldmethod=syntax
  autocmd FileType diff      setlocal foldmethod=syntax
  autocmd FileType markdown  setlocal foldmethod=syntax wrap linebreak
  autocmd FileType pandoc    setlocal foldmethod=syntax wrap linebreak
augroup END
"}}}

"|    User Interface                                                        {{{
"|-----------------------------------------------------------------------------
"set visualbell
"set hidden            	" don’t ask before closing a window
                      	" XXX this may leave a lot of empty buffers

set showmode          	" display current mode blow the status line
set showtabline=2     	" show tabbar even for a single buffer
set laststatus=2      	" always show the status line
set ruler             	" display line/col position in the status line
set cursorline        	" highlight current line
set virtualedit=block 	" easier rectangular selections

" line numbers
set number            	" show absolute line numbers (:set nu)
"set relativenumber    	" show relative line numbers (:set rnu)
set scrolloff=5       	" number of screen lines to show around the cursor
set numberwidth=6     	" minimal number width (not working?)

" show tabs / nbsp / trailing spaces
set list listchars=nbsp:¤,tab:··,trail:¤,extends:▶,precedes:◀

" syntax highlighting
syntax enable
" set synmaxcol=200     	" don’t try to highlight super long lines

"}}}

"|    Keyboard Mappings                                                     {{{
"|-----------------------------------------------------------------------------

" disable digraph input to make ^ work faster
set nodigraph

if !has('nvim')
  " make Y copy to the end of the line (more consistant with D, C, etc.)
  map Y y$
  " U is useless (except for Vi compatibility), make it a redo instead
  map U <C-r>
endif

" the Ex mode is useless (except for Vi compatibility), disable it
" map Q <Nop>
" Alternative: use q: instead
nmap Q q:

" g<Enter> to follow tags (e.g. help links)
map g<CR> <C-]>

" make K more consistent with J (J = join, K = split)
" nmap K i<CR><Esc>k$
" Alternative: use a real 'Man' on K
" runtime ftplugin/man.vim
" nmap K :Man <C-r><C-w><CR>

" lazy escape with 'kj' (qwerty / qwertz / azerty users)
" Note: if the 'paste' option is set, then insert mode maps are disabled.
imap kj <Esc>
cmap kj <Esc>
imap KJ <Esc>
cmap KJ <Esc>
"}}}

" Source configuration files on save to apply all changes immediately.
augroup configurationFiles
  autocmd! BufWritePost settings.vim  source %
  autocmd! BufWritePost Xresources    !xrdb -load ~/.Xresources
  autocmd! BufWritePost .Xresources   !xrdb -load ~/.Xresources
  autocmd! BufWritePost tmux.conf     !tmux source-file ~/.tmux.conf
  autocmd! BufWritePost .tmux.conf    !tmux source-file ~/.tmux.conf
augroup END

" Bluecime guidelines: 4-space indents & 100-character lines
set textwidth=100
set winwidth=110
set tabstop=4
set shiftwidth=4
set softtabstop=4

nnoremap g0 :set ts=2 sts=2 sw=2 tw=80 wiw=90<CR>
nnoremap g1 :set ts=4 sts=4 sw=4 tw=100 wiw=110<CR>

" auto-reload files when modified outside of Vim
set autoread
" autocmd CursorHold * checktime

" vim: set ft=vim fdm=marker fmr={{{,}}} fdl=0:
