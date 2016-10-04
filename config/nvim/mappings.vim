"|
"| File    : ~/.config/nvim/mappings.vim
"| Author  : Fabien Cazenave
"| Source  : https://github.com/fabi1cazenave/dotFiles
"| Licence : WTFPL
"|

"|    Space, Backspace, Enter                                               {{{
"|-----------------------------------------------------------------------------
" These keys are so easy to reach that they must be mapped to something useful.

" Suggestion: Space as leader key — Spacemacs style!
" nmap <Space> <Nop>
" let mapleader = "\<Space>"

" Suggestion: Enter as leader key — good choice on a TypeMatrix
" let mapleader = "\<Enter>"

" Suggestion: quick save on <Enter>
" (if you wonder why `noremap`, try with `map` ^^)
" nnoremap <silent> <CR> :update<CR>

" Note: remapping <Enter> also affects the command-line, so let’s revert:
" cnoremap <CR> <C-c><CR>

" Suggestion: Space/BackSpace for Page Down/Up
" (using `noremap` in case the “badass mode” is on)
noremap <BS>    <PageUp>
noremap <Space> <PageDown>
" }}}

"|    General mappings                                                      {{{
"|-----------------------------------------------------------------------------

" spare one VimGolf point (and a Shift press) on :q, :w, :e, :x
map <Leader>q :q<CR>
map <Leader>w :w<CR>
map <Leader>e :e<CR>
map <Leader>x :x<CR>

" lazy code folding / unfolding
" Warning: this disables <C-i>, which is *very* useful along with <C-o>.
" So <C-i> and <C-o> are replaced by <M-n> and <M-p>, see the `Alt-*` section.
map <Tab>   za
map <S-Tab> zA
" fold stuff around selection
"vmap <Leader>za <Esc>`<kzfgg`>jzfG`<

" folding levels
map <silent> z0 :set fdl=0<CR>
map <silent> z1 :set fdl=1<CR>
map <silent> z2 :set fdl=2<CR>
map <silent> z3 :set fdl=3<CR>
map <silent> z4 :set fdl=4<CR>
map <silent> z5 :set fdl=5<CR>
map <silent> z6 :set fdl=6<CR>
map <silent> z7 :set fdl=7<CR>
map <silent> z8 :set fdl=8<CR>
map <silent> z9 :set fdl=9<CR>

" indexes the last search
nmap g/ :vimgrep /<C-r>//j %<Bar>cw<CR>

" quick way to clear the current search
map <silent> <Leader><Space> :nohlsearch<CR>
"}}}

"|    Alt-* mappings                                                        {{{
"|-----------------------------------------------------------------------------
" Death to the <Control> key!

" Note: <Alt>-shortcuts work on xterm, gVim and MacVim (= the 8th bit is set),
" but are transformed into <Esc> sequences in *rxvt and most terminal
" emulators (= "8bit-clean" behavior).
" Quick and dirty way to free all <Alt> shortcuts in gVim: set guioptions-=m

" MacOSX (enable Alt/Meta key)
" XXX only works with MacVim, and disables <Option> keys
"set macmeta

" in gVim, Alt sets the 8th bit; otherwise, assume the terminal is 8-bit clean
" Note: Neovim is *not* 8bit-clean (as of version 0.1). THIS IS SO LAME.
" https://github.com/neovim/neovim/issues/3727
if !exists('g:MetaSendsEscape')
  let g:MetaSendsEscape = !has('gui_running')
endif

" These Alt+[left-hand] shortcuts aren't so efficient with an AltGr layout
" but they're still much better on a laptop without right Control key...
if g:MetaSendsEscape
  noremap <Esc>r <C-r>
  noremap <Esc>v <C-v>
  noremap <Esc>x <C-x>
  noremap <Esc>a <C-a>
  " inoremap <Esc>o <C-o>
else
  noremap <M-r> <C-r>
  noremap <M-v> <C-v>
  noremap <M-x> <C-x>
  noremap <M-a> <C-a>
  " inoremap <M-o> <C-o>
endif

" jump to newer/older position
" -- this frees the <Tab> key (C-i), which can be used for useful stuff.
if g:MetaSendsEscape
  noremap <Esc>n <C-i>
  noremap <Esc>p <C-o>
else
  noremap <M-n> <C-i>
  noremap <M-p> <C-o>
endif

" lazy command-line history: hold down Meta, dot, j|k
if g:MetaSendsEscape
  nmap <Esc>. :
  cmap <Esc>j <Down>
  cmap <Esc>k <Up>
else
  nmap <M-.> :
  cmap <M-j> <Down>
  cmap <M-k> <Up>
endif

" capitalize previous word
" Note: <C-u> deletes text entered in the current line.
if g:MetaSendsEscape
  imap <Esc>u <C-o>b<C-o>gUw<C-o>w
  imap <Esc>U <C-o>B<C-o>gUW<C-o>W
else
  imap   <M-u> <C-o>b<C-o>gUw<C-o>w
  imap <S-M-u> <C-o>B<C-o>gUW<C-o>W
endif
"}}}

"|    Windows and Tabs                                                      {{{
"|-----------------------------------------------------------------------------
" See also: https://github.com/fabi1cazenave/suckless.vim

" scroll current window
map <C-j> <C-y>
map <C-k> <C-e>

" switching / moving / creating tabs
if g:MetaSendsEscape
  nmap <silent> <Esc>y :tabnew<CR>
  nmap <silent> <Esc>u :tabprev<CR>
  nmap <silent> <Esc>i :tabnext<CR>
  nmap <silent> <Esc>U :exe "tabmove " .(tabpagenr()-2)<CR>
  nmap <silent> <Esc>I :exe "tabmove " . tabpagenr()<CR>
else
  nmap <silent>   <M-y> :tabnew<CR>
  nmap <silent>   <M-u> :tabprev<CR>
  nmap <silent>   <M-i> :tabnext<CR>
  nmap <silent> <S-M-u> :exe "tabmove " .(tabpagenr()-2)<CR>
  nmap <silent> <S-M-i> :exe "tabmove " . tabpagenr()<CR>
endif

" open a vertical split and switch over (v)
nmap <leader>v <C-w>v
nmap         ŭ <C-w>v

" open a horizontal split and switch over (s)
nmap <leader>s <C-w>s
nmap         ß <C-w>s
"}}}

"|    Selection tricks                                                      {{{
"|-----------------------------------------------------------------------------

" keep selection active when indenting/unindenting
vmap < <gv
vmap > >gv

" keep selection active when incrementing/decrementing
vmap <C-a> <C-a>gv
vmap <C-x> <C-x>gv

" select the pasted text (http://vim.wikia.com/wiki/Selecting_your_pasted_text)
" nmap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
nmap gp `[v`]
" }}}

" Wonder how often you hit <Esc> when already in normal mode?
" Uncomment the following line to find out. Abandon all hope.
" map <Esc> ggcGboo!<CR><Esc>

" swap ,/; in normal mode (feels more natural with my qwerty-lafayette layout)
" (to be disabled when using my patched Fanf,ingTastic;)
noremap , ;
noremap ; ,
vnoremap , ;
vnoremap ; ,
onoremap , ;
onoremap ; ,

" vim: set fdm=marker fmr={{{,}}} fdl=0:
