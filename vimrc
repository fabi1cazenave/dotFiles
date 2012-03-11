"|
"| File          : ~/.vimrc
"| Last modified : 2012-02-05
"| Author        : Fabien Cazenave
"| Licence       : WTFPL
"| vim           : set fdm=marker:fmr=<<<,>>>:fdl=0:
"|
"| See also these .vimrc files:
"|   https://gist.github.com/1689941#file_.vimrc
"|   http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"|   http://www.slackorama.com/projects/vim/vimrc.html
"|   http://amix.dk/vim/vimrc.html
"|
"| Other valuable Vim links:
"|   http://www.reddit.com/r/vim/
"|   http://amix.dk/blog/viewLabelPosts/5
"|   http://www.moolenaar.net/habits.html
"|   http://gpl.internetconnection.net/vi/
"|

" source configuration files on save to apply all changes immediately
if has("autocmd")
  autocmd! BufWritePost .vimrc      source ~/.vimrc
  autocmd! BufWritePost _vimrc      source ~/_vimrc
  autocmd! BufWritePost vimrc       source ~/.vimrc
  autocmd! BufWritePost .Xresources !xrdb -load ~/.Xresources
  autocmd! BufWritePost Xresources  !xrdb -load ~/.Xresources
  autocmd! BufWritePost .gtkrc-2.0  !gtkrc-reload
  autocmd! BufWritePost gtkrc-2.0   !gtkrc-reload
  autocmd! BufWritePost gtkrc       !gtkrc-reload
endif

" Modern / standard / Notepad-like behavior:
" load "mwwin.vim" or "notepad.vim" <https://github.com/fabi1cazenave/gnupad>
"source $VIMRUNTIME/mswin.vim
set nocompatible   " required for a multi-level undo/redo stack
set mouse=a        " enable mouse selection


"|============================================================================
"|    Settings                                                             <<<
"|============================================================================

"|    Terminal                                                             <<<
"|----------------------------------------------------------------------------

set title

"set shell=/bin/zsh

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
"              16 colors, and will blink if forced to more. :-/
if (&term == 'xterm') || (&term == 'screen') || (&term == 'screen-bce') || (&term == 'screen-color')
  set t_Co=256
endif

" send the current filename to GNU Screen (not working?)
"if ($TERM=='screen') || ($TERM=='screen-color')
if (&term == 'screen') || (&term == 'screen-bce') || (&term == 'screen-color')
  exe "set title titlestring=Vim:%f"
  exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
endif

" GNU screen
"http://www.semicomplete.com/blog/productivity/39.html
"map <M-v>  :silent !screen -X split<CR>:silent !screen -X focus down<CR>:silent !screen -X screen /home/kaze/.vim/screener.sh<CR>:redraw!<CR>
"map <Esc>v :silent !screen -X split<CR>:silent !screen -X focus down<CR>:silent !screen -X screen /home/kaze/.vim/screener.sh<CR>:redraw!<CR>

" notify when Xim or another IME is used (not working?)
"if has('multi_byte_ime')
  "highlight Cursor   guifg=NONE guibg=Green
  "highlight CursorIM guifg=NONE guibg=Purple
"endif
">>>

"|    User Interface                                                       <<<
"|----------------------------------------------------------------------------

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
colorscheme kalahari
syntax on

set showtabline=2           " show tabbar even for a single buffer

" highlight nbsp ( )
"highlight NbSp ctermbg=blue guibg=red
"match NbSp /\%xa0/

" alternative: highlight non-ASCII chars
"match Error /[\x7f-\xff]/

" better alternative: listchars
"set listchars=tab:▶\ ,trail:◀,extends:»,precedes:«
set listchars=nbsp:¤,tab:>·,trail:¤,extends:>,precedes:<
set list
">>>

"|    General settings                                                     <<<
"|----------------------------------------------------------------------------

" Is supposed to improve terminal emulation greatly
set guipty
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
set cindent
set smartindent
"set autoindent

" search settings
set hlsearch       " highlight search results
set incsearch      " incremental search: find as you type
set ignorecase     " search is case-insensitive...
set smartcase      " ... except if the search pattern contains upper-case chars

" case-insensitive tab completion
set wildmode=longest:list
if exists("&wildignorecase")
  set wildignorecase
endif

" disable incrementation of octal numbers
set nrformats=hex

" imported Zenwalk settings (ZenWalk rulez)
set updatecount=0   " number of characters typed to cause a swap file update
set backspace=2     " <BackSpace> behavior in Insert mode
set textwidth=80    " line length above which to break a line (local to buffer)
set nowrap
set nowrapscan
"let c_comment_strings=1     " ???
"set t_kD=^?                 " ???
" delete / backspace
"map ^H X
"map \e[3~ x

"set sessionoptions="blank,buffers,curdir,folds,help,localoptions,options,resize,slash,tabpages,unix,winpos,winsize"
"set sessionoptions="blank,buffers,curdir,folds,help,options,tabpages,winsize"
"set sessionoptions="folds,tabpages,winsize"

" trailing whitespace kills puppies
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

">>>

">>>

"|============================================================================
"|    Plugins                                                              <<<
"|============================================================================

" try:
" https://github.com/vim-scripts/inline_edit.vim.git

"|    Pathogen                                                             <<<
"|----------------------------------------------------------------------------

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on
">>>

"|    Tabular                                                              <<<
"|----------------------------------------------------------------------------
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:<CR>
  vmap <Leader>a: :Tabularize /:<CR>
  "nmap <Leader>a: :Tabularize /:\zs<CR>
  "vmap <Leader>a: :Tabularize /:\zs<CR>
endif
">>>

"|    Conque Term                                                          <<<
"|----------------------------------------------------------------------------

" Assign Alt-Return to a new Conque Term like in dwm/wmii/i3
" Warning: with xterm you'll have to disable Alt-Return first by adding these
"          two lines to your ~/.Xresources file:
" XTerm*fullscreen: never
" XTerm.omitTranslation: fullscreen

map <silent> <Esc><Return> :ConqueTermSplit bash<CR>
">>>

"|    Vim-orgmode                                                          <<<
"|----------------------------------------------------------------------------

"filetype on
"filetype plugin on
""filetype indent on
">>>

"|    Ranger as Vim file manager                                           <<<
"|----------------------------------------------------------------------------
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
">>>

"|    Zen Coding                                                           <<<
"|----------------------------------------------------------------------------

let g:user_zen_leader_key = '<S-Return>'
">>>

"|    SuperTab                                                             <<<
"|----------------------------------------------------------------------------
" requires pydoc?

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
autocmd FileType python     set omnifunc=pythoncomplete#Complete

let g:SuperTabDefaultCompletionType = 'context'
set completeopt=menuone,longest,preview
">>>

" comment plugin: ~/.vim/plugin/NERD_commenter.vim
" see: http://www.vim.org/scripts/script.php?script_id=1218

" web browser plugin: ~/.vim/plugin/browser.vim
" see: http://www.vim.org/scripts/script.php?script_id=2227
"vmap ,o :call OpenWebBrowser("<C-R><C-A>")<CR>

"let g:vimwiki_home = "/home/kaze/Documents/wiki/"
"let g:miniBufExplVSplit = 1

"noremap <Esc><Return> :exe ":Project"<CR>

" tags: ~/.vim/plugin/taglist.vim
" see: http://www.vim.org/scripts/script.php?script_id=273
"noremap <silent> <M-t> :Tlist<CR>
"noremap <silent> <Esc>t :Tlist<CR>
"let Tlist_Use_Right_Window = 1

">>> plugins

"|============================================================================
"|    Mappings                                                             <<<
"|============================================================================

"|    General mappings                                                     <<<
"|----------------------------------------------------------------------------

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
"set foldmethod=indent
autocmd FileType html,xhtml,javascript,css,c,cpp,python setlocal foldmethod=indent

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
"noremap gF gf<CR>:tabnew<CR>:bn<CR>:exe "silent! tabmove " . (tabpagenr() - 2)<CR>:tabp<CR>

" Alt+E to open the file explorer
"noremap <silent> <M-e>  :Ex<CR>
"noremap <silent> <Esc>e :Ex<CR>
">>>

"|    Alt-* mappings                                                       <<<
"|----------------------------------------------------------------------------
" Death to the <Control> key!

" Note: <Alt>-shortcuts work on xterm, gVim and MacVim (= the 8th bit is set),
" but are transformed into <Esc> sequences in *rxvt and most terminal
" emulators (= "8bit-clean" behavior).
" Quick and dirty way to free all <Alt> shortcuts in gVim: set guioptions-=m

" MacOSX (enable Alt/Meta key)
" XXX only works with MacVim, and disables <Option> keys
"set macmeta

" These Alt+[left-hand] shortcuts aren't so efficient with an AltGr layout
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

" Meta+[BackSpace|left|right]: word-by-word
inoremap <Esc><BS> <C-o>dB<C-o>x
map <M-Left>  <C-Left>
map <M-Right> <C-Right>

" Meta+[up|down]: paragraph-by-paragraph
noremap <C-Up> {
noremap <C-Down> }
noremap <M-Up> {
noremap <M-Down> }
">>>

"|    QWERTY mappings                                                      <<<
"|----------------------------------------------------------------------------

" lazy escape with 'jj'
inoremap jj <C-[>

" clipboard: cut/copy/paste
" (requires vim-gtk or vim-gnome with Ubuntu 11.04)
"map <C-x> "+x
"map <C-c> "+y
"map <C-v> "+P

" +1|-1 with C-[j|k] (useful when no right Ctrl key)
"noremap <C-j> <C-x>
"noremap <C-k> <C-a>

" These mappings should be useable with both Vim and Vimperator

"noremap <Esc> zz
"noremap <Esc><Return> zz

" switching buffers & windows
"noremap <M-n> :bn<CR>
"noremap <M-p> :bp<CR>
"noremap <M-w> <C-w>
"noremap <M-w><M-w> <C-w><C-w>
"noremap <Leader>w  <C-w>
"noremap <Leader>ww <C-w><C-w>
"
noremap <Esc>n :bn<CR>
noremap <Esc>p :bp<CR>
noremap <Esc>w <C-w>
noremap <Esc>w<Esc>w <C-w><C-w>

" switching / moving / creating tabs
"noremap <silent>   <M-y> :tabnew<CR>
"noremap <silent>   <M-u> :tabprev<CR>
"noremap <silent>   <M-i> :tabnext<CR>
"noremap <silent> <S-M-u> :exe "tabmove " .(tabpagenr()-2)<CR>
"noremap <silent> <S-M-i> :exe "tabmove " . tabpagenr()<CR>
"
noremap <silent> <Esc>y :tabnew<CR>
noremap <silent> <Esc>u :tabprev<CR>
noremap <silent> <Esc>i :tabnext<CR>
noremap <silent> <Esc>U :exe "tabmove " .(tabpagenr()-2)<CR>
noremap <silent> <Esc>I :exe "tabmove " . tabpagenr()<CR>

" code completion
"inoremap <M-j> <C-n>
"inoremap <M-k> <C-p>

" alternative: use <Tab> for auto-completion in insertion mode
" XXX disabled for SuperTab
"inoremap <Tab> <C-n>
"inoremap <S-Tab> <C-p>

"inoremap <Esc>i <C-x><C-o>
"inoremap <Esc><Tab> <C-x><C-o>

" Omnicomplete
"inoremap <M-f> <C-x><C-o>
"inoremap <M-j> <C-o>
"inoremap <M-k> <C-p>
"inoremap <Esc>f <C-x><C-o>
"inoremap <Esc>j <Down>
"inoremap <Esc>k <Up>
"inoremap <Esc>j <C-o>
"inoremap <Esc>k <C-p>

">>>

">>>

