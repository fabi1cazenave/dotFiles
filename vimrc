"|
"| File    : ~/.vimrc
"| Author  : Fabien Cazenave
"| Source  : https://github.com/fabi1cazenave/dotFiles
"| Licence : WTFPL
"|
"| Minimalistic Vim configuration, shared as a starting point for beginners.
"| I’ve switched to Neovim. My real config can be found in config/nvim.
"|

set nocompatible
syntax on

" visual helpers
set number
set ruler
set showcmd

" incremental search
set hlsearch
set incsearch
if has('nvim')
  set inccommand=nosplit
endif

" two-space auto-indentation
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" OK, wrap lines but don't split words
set wrap
set linebreak

" auto-complete with <Tab> in command mode
set wildmenu
set wildmode=longest,full

" beginners should probably uncomment these two lines
" set clipboard=unnamedplus
" set mouse=a

" three mappings I can’t live without
nmap Y y$
nmap U <C-r>
imap kj 
