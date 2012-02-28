"|
"| File          : ~/.vimrc
"| Last modified : 2012-02-05
"| Author        : Fabien Cazenave
"| Licence       : WTFPL
"|

" source the .vimrc file on save to apply all changes immediately
if has("autocmd")
  autocmd! BufWritePost .vimrc      source ~/.vimrc
  autocmd! BufWritePost .Xresources !xrdb -load ~/.Xresources
  autocmd! BufWritePost .gtkrc-2.0  !gtkrc-reload
  autocmd! BufWritePost gtkrc       !gtkrc-reload
endif 

" see also these interesting .vimrc files:
" http://thomas.tanreisoftware.com/?p=82
" http://www.slackorama.com/projects/vim/vimrc.html
" http://www.dotfiles.com/files/9/451_.vimrc
" http://www.dotfiles.com/files/9/53_.vimrc
" http://amix.dk/vim/vimrc.html
" http://amix.dk/blog/viewLabelPosts/5
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"

"set sessionoptions="blank,buffers,curdir,folds,help,localoptions,options,resize,slash,tabpages,unix,winpos,winsize"
"set sessionoptions="blank,buffers,curdir,folds,help,options,tabpages,winsize"
"set sessionoptions="folds,tabpages,winsize"


"|============================================================================
"|    Pathogen
"|============================================================================

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

"|============================================================================
"|    Tabular
"|============================================================================
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:<CR>
  vmap <Leader>a: :Tabularize /:<CR>
  "nmap <Leader>a: :Tabularize /:\zs<CR>
  "vmap <Leader>a: :Tabularize /:\zs<CR>
endif

"|============================================================================
"|    Conque Term
"|============================================================================

" Assign Alt-Return to a new Conque Term like in dwm/wmii/i3
" Warning: with xterm you'll have to disable Alt-Return first by adding these
"          two lines to your ~/.Xresources file:
" XTerm*fullscreen: never
" XTerm.omitTranslation: fullscreen

map <silent> <Esc><Return> :ConqueTermSplit bash<CR>

"|============================================================================
"|    Vim-orgmode
"|============================================================================

filetype on
filetype plugin on
"filetype indent on

"|============================================================================
"|    Ranger as vim file manager
"|============================================================================
" http://ornicar.github.com/2011/02/12/ranger-as-vim-file-manager.html

function! Ranger()
  "let tmpfile = '/tmp/chosen'
  "silent !ranger %:h --choosefile=/tmp/chosen   
  let tmpfile = substitute(system('mktemp -u'), '\n', '', '')
  silent exec '!ranger --choosefile='.tmpfile
  if filereadable(tmpfile)
    exec 'edit '. system('cat '.tmpfile)
    call delete(tmpfile)
  endif
  redraw!
endfunction
noremap <silent> <Esc>e :call Ranger()<CR>

" when using autosession.vim, add this line to ~/.config/ranger/rc.conf:
" map e shell vim

"|============================================================================
"|    Zen Coding
"|============================================================================

let g:user_zen_leader_key = '<S-Return>'

"|============================================================================
"|    Terminal
"|============================================================================

set title

" color for xiterm, rxvt, nxterm, color-xterm
"if has("terminfo")
  "set t_Co=8
  "set t_Sf=\e[3%p1%dm
  "set t_Sb=\e[4%p1%dm
"else
  "set t_Co=8
  "set t_Sf=\e[3%dm
  "set t_Sb=\e[4%dm
"endif

" [GNU/Linux] xterm supports 256 colors out of the box
"             but 'tput colors' returns '8' if ~/.termcap isn't set
" see: http://zecrazytux.net/Softwares/Perfect_console_session.html
" XXX [MacOSX] Terminal.app is declared as "xterm-color" but only supports
"              8 colors, and will blink if forced to more. :-/
if (&term == 'xterm') || (&term == 'screen') || (&term == 'screen-bce') || (&term == 'screen-color')
  set t_Co=256
endif

" send the current filename to GNU Screen (not working?)
"if ($TERM=='screen') || ($TERM=='screen-color')
if (&term == 'screen') || (&term == 'screen-bce') || (&term == 'screen-color')
  exe "set title titlestring=Vim:%f"
  exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
endif

" notify when Xim or another IME is used (not working?)
"if has('multi_byte_ime')
  "highlight Cursor   guifg=NONE guibg=Green
  "highlight CursorIM guifg=NONE guibg=Purple
"endif

"|============================================================================
"|    User Interface
"|============================================================================

"behave mswin " ???
set showmode
set cursorline
set showfulltag
set ruler
"set laststatus=2 " always show statusline

" MacOSX (enable Alt/Meta key)
" XXX only works with MacVim, and disables <Option> keys
"set macmeta

" mouse
"set mouse=r
set mouse=a
set mousehide

set guioptions=reTm
set guifont=Monospace\ 9
colorscheme kalahari256
"colorscheme desert
syntax on

set showtabline=2           " show tabbar even for a single buffer

" highlight nbsp ( )
highlight NbSp ctermbg=blue guibg=red
match NbSp /\%xa0/

" alternative: highlight non-ASCII chars
"match Error /[\x7f-\xff]/

"|============================================================================
"|    General settings
"|============================================================================

"set shell=/bin/zsh
" Is supposed to improve terminal emulation greatly
set guipty 
set nocompatible
set modelines=0
"set visualbell

" text display
set number           " set nu
"set relativenumber   " rnu
"set scrolloff=5     " number of screen lines to show around the cursor
set nuw=6           " fixed number width (not working?)
set showmatch       " when inserting a bracket, briefly jump to its match
"set filetype=vim    " triggers the FileType event when set (local to buffer)

" use the current file's directory as Vim's working directory
set autochdir       " XXX not working on MacOSX
" don't create backupfiles everywhere, but just in ~/.vim/backup
set backupdir=~/.vim/backup
set dir=~/.vim/backup

" expand tabs with two spaces (= Mozilla guidelines)
set tabstop=2
set shiftwidth=2
set softtabstop=2

" indentation
set expandtab
set foldmethod=indent
set cindent
set smartindent
"set autoindent

" search
set hlsearch
set ignorecase
set smartcase
set incsearch

" disable incrementation of octal numbers
set nrformats=hex

" imported Zenwalk settings (ZenWalk rulez)
set updatecount=0   " number of characters typed to cause a swap file update
set backspace=2     " <BackSpace> behavior in Insert mode
set textwidth=80    " line length above which to break a line (local to buffer)
set nowrap
set nowrapscan
let c_comment_strings=1     " ???
set t_kD=^?                 " ???
" delete / backspace
"map ^H X
map \e[3~ x


"|============================================================================
"|    General mappings
"|============================================================================

"noremap <S-Return> zz
"noremap <Esc><Return> :exe ":Project"<CR>

" disable digraph input to make <^> work faster (not working)
set nodigraph

"let mapleader = ","
" alternative: use <Return> as <Leader>
map <Return> ⁰
let mapleader = "⁰"
noremap <Leader><Return> zz
" alternative: use <Space> as <Leader>
"let mapleader = "°"
"map <Space> °

" Make Y copy to the end of the line (more consistant with D, C, etc.)
"map Y y$"

" lazy scrolling
noremap <BS> <PageUp>
noremap <Space> <PageDown>
"noremap <S-BS> <C-u>
"noremap <S-Space> <C-d>

" lazy code folding / unfolding
noremap <Tab>   za
noremap <S-Tab> zA

" use <Tab> as <Esc> in insertion and visual modes
"inoremap <Tab> <Esc>
"vnoremap <Tab> <Esc>
"inoremap <S-Tab> <Tab>
"vnoremap <S-Tab> <Tab>

" switching / moving / creating tabs
noremap g<Tab>   gt
noremap g<S-Tab> gT
noremap <C-Tab>   gt
noremap <C-S-Tab> gT
noremap <silent> <C-PageUp>   :exe "tabmove " .(tabpagenr()-2)<CR>
noremap <silent> <C-PageDown> :exe "tabmove " . tabpagenr()<CR>

" file navigation
noremap gF gf<CR>:tabnew<CR>:bn<CR>:exe "silent! tabmove " . (tabpagenr() - 2)<CR>:tabp<CR>

" tags: ~/.vim/plugin/taglist.vim
" see: http://www.vim.org/scripts/script.php?script_id=273
noremap <silent> <M-t> :Tlist<CR>
"noremap <silent> <Esc>t :Tlist<CR>
let Tlist_Use_Right_Window = 1

" comment plugin: ~/.vim/plugin/NERD_commenter.vim
" see: http://www.vim.org/scripts/script.php?script_id=1218

" web browser plugin: ~/.vim/plugin/browser.vim
" see: http://www.vim.org/scripts/script.php?script_id=2227
vmap ,o :call OpenWebBrowser("<C-R><C-A>")<CR>

source ~/.vim/mappings.vim
"source ~/.vim/suckless.vim

"let g:vimwiki_home = "/home/kaze/Documents/wiki/"
let g:miniBufExplVSplit = 1

" Alt+E to open the file explorer
"noremap <silent> <M-e>  :Ex<CR>
"noremap <silent> <Esc>e :Ex<CR>

" GNU screen
"http://www.semicomplete.com/blog/productivity/39.html
"map <M-v>  :silent !screen -X split<CR>:silent !screen -X focus down<CR>:silent !screen -X screen /home/kaze/.vim/screener.sh<CR>:redraw!<CR>
"map <Esc>v :silent !screen -X split<CR>:silent !screen -X focus down<CR>:silent !screen -X screen /home/kaze/.vim/screener.sh<CR>:redraw!<CR>

" Death to the <Control> key!
" these Alt+[left-hand] shortcuts aren't so efficient with an AltGr layout
" but they're still much better on a laptop without right Control key...
"noremap  <M-r> <C-r>
"noremap  <M-v> <C-v>
"noremap  <M-x> <C-x>
"noremap  <M-a> <C-a>
"inoremap <M-o> <C-o>
noremap  <Esc>r <C-r>
noremap  <Esc>v <C-v>
noremap  <Esc>x <C-x>
noremap  <Esc>a <C-a>
inoremap <Esc>o <C-o>

" +1|-1 with C-[j|k] (useful when no right Ctrl key)
noremap <C-j> <C-x>
noremap <C-k> <C-a>

" clipboard: cut/copy/paste
" (requires vim-gtk or vim-gnome with Ubuntu 11.04)
map <C-x> "+x
map <C-c> "+y
map <C-v> "+P

" Meta+[BackSpace|left|right]: word-by-word
inoremap <Esc><BS> <C-o>dB<C-o>x
map <M-Left>  <C-Left>
map <M-Right> <C-Right>

" Meta+[up|down]: paragraph-by-paragraph
noremap <C-Up> {
noremap <C-Down> }
noremap <M-Up> {
noremap <M-Down> }

