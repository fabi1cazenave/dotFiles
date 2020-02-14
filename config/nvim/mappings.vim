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

" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! w !sudo tee > /dev/null %

" tupperVim 1803-Lyon: create the file if the `gf` target does not exist
nmap gf :e  <cfile><CR>
nmap gs :sp <cfile><CR>
nmap gS :vs <cfile><CR>

" spare one VimGolf point (and a Shift press) on :q, :w, :e, :x
nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
nmap <Leader>e :e<CR>
nmap <Leader>x :x<CR>

" lazy code folding / unfolding
" Warning: this disables <C-i>, which is *very* useful along with <C-o>.
" So <C-i> and <C-o> are replaced by <M-n> and <M-p>, see the `Alt-*` section.
nmap <Tab>   za
nmap <S-Tab> zA
" fold stuff around selection
"vmap <Leader>za <Esc>`<kzfgg`>jzfG`<

" folding levels
nmap <silent> z0 :set fdl=0<CR>
nmap <silent> z1 :set fdl=1<CR>
nmap <silent> z2 :set fdl=2<CR>
nmap <silent> z3 :set fdl=3<CR>
nmap <silent> z4 :set fdl=4<CR>
nmap <silent> z5 :set fdl=5<CR>
nmap <silent> z6 :set fdl=6<CR>
nmap <silent> z7 :set fdl=7<CR>
nmap <silent> z8 :set fdl=8<CR>
nmap <silent> z9 :set fdl=9<CR>

" indexes the last search
nmap g/ :vimgrep /<C-r>//j %<Bar>cw<CR>

" quick way to clear the current search
" Alternative: Plug 'romainl/vim-cool'
" Alternative: Plug 'junegunn/vim-slash'
" map <silent> <Leader><Space> :nohlsearch<CR>
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
if has('nvim')
  let g:MetaSendsEscape = 0
elseif !exists('g:MetaSendsEscape')
  let g:MetaSendsEscape = !has('gui_running')
endif

" These Alt+[left-hand] shortcuts aren't so efficient with an AltGr layout
" but they're still much better on a laptop without right Control key...
if g:MetaSendsEscape
  nnoremap <Esc>v <C-v>
  nnoremap <Esc>x <C-x>
  nnoremap <Esc>a <C-a>
else
  nnoremap <M-v> <C-v>
  nnoremap <M-x> <C-x>
  nnoremap <M-a> <C-a>
endif

" jump to newer/older position
" -- this frees the <Tab> key (C-i), which can be used for useful stuff.
if g:MetaSendsEscape
  nnoremap <Esc>n <C-i>
  nnoremap <Esc>p <C-o>
else
  nnoremap <M-n> <C-i>
  nnoremap <M-p> <C-o>
endif

" lazy command-line history: hold down Meta, dot, j|k
if g:MetaSendsEscape
  nnoremap <Esc>. :
  cnoremap <Esc>j <Down>
  cnoremap <Esc>k <Up>
else
  nnoremap <M-.> :
  cnoremap <M-j> <Down>
  cnoremap <M-k> <Up>
endif

" insert-mode Alt-* shortcuts will never work properly with Vim
if has('nvim')
  " capitalize previous word
  inoremap <M-u> <C-o>b<C-o>gUw<C-o>w
  inoremap <M-U> <C-o>B<C-o>gUW<C-o>W
  " escape next command
  inoremap <M-o> <C-o>
endif
"}}}

"|    Windows and Tabs                                                      {{{
"|-----------------------------------------------------------------------------
" See also: https://github.com/fabi1cazenave/suckless.vim

" scroll current window (conflicts with ALE shortcuts)
" map <C-j> <C-y>
" map <C-k> <C-e>

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
nnoremap , ;
nnoremap ; ,
vnoremap , ;
vnoremap ; ,
onoremap , ;
onoremap ; ,

nmap <C-S-j> :echo 'FOO'<CR>
nmap <C-S-k> :echo 'BAR'<CR>

" map <S-C-j> :echo 'FOO'<CR>
" map <S-C-k> :echo 'BAR'<CR>

" map <C-J> :echo 'FOO'<CR>
" map <C-K> :echo 'BAR'<CR>

nmap <C-j> :echo 'foo'<CR>
nmap <C-k> :echo 'bar'<CR>

map [<Space> O<Esc>
map ]<Space> o<Esc>

" noremap <M-n> g,
" noremap <M-p> g;

" vim: set fdm=marker fmr={{{,}}} fdl=0:
