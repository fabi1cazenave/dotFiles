"|
"| File    : ~/.config/nvim/init.vim
"| Author  : Fabien Cazenave
"| Source  : https://github.com/fabi1cazenave/dotFiles
"| Licence : WTFPL
"|

" tupperVim 1803-Lyon: create the file if the `gf` target does not exist
map gf :e  <cfile><CR>
map gs :sp <cfile><CR>
map gS :vs <cfile><CR>

" 24bit colors, baby!
set termguicolors

" Plugins and extra mappings that are probably not worth sharing with humans.
source ~/.config/nvim/mappings.vim
source ~/.config/nvim/plugins.vim

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
set foldmethod=indent

augroup indents
  autocmd FileType ?akefile set noexpandtab
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  " autocmd FileType html,xhtml,javascript,css,c,cpp,python setlocal foldmethod=indent
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

" make Y copy to the end of the line (more consistant with D, C, etc.)
map Y y$

" U is useless (except for Vi compatibility), make it a redo instead
map U <C-r>

" the Ex mode is useless (except for Vi compatibility), disable it
" map Q <Nop>
" Alternative: use q: instead
nmap Q q:
" Alternative
" nmap q b
" nmap Q B

" g<Enter> to follow tags (e.g. help links)
map g<CR> <C-]>

" make K more consistent with J (J = join, K = split)
nmap K i<CR><Esc>k$
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
  autocmd! BufWritePost init.vim      source %
  autocmd! BufWritePost Xresources    !xrdb -load ~/.Xresources
  autocmd! BufWritePost .Xresources   !xrdb -load ~/.Xresources
  autocmd! BufWritePost tmux.conf     !tmux source-file ~/.tmux.conf
  autocmd! BufWritePost .tmux.conf    !tmux source-file ~/.tmux.conf
augroup END

" vim: set ft=vim fdm=marker fmr={{{,}}} fdl=0:
