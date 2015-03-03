"|
"| File    : ~/.vim/mappings.vim
"| Author  : Fabien Cazenave
"| Source  : https://github.com/fabi1cazenave/dotFiles
"| Licence : WTFPL
"|


augroup mappings
  autocmd! BufWritePost mappings.vim source %
augroup END

" disable digraph input to make ^ work faster
set nodigraph

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" clear current search
" map <silent> <Leader><Space> :let @/ = '\v$.'<CR>
map <silent> <Leader><Space> :noh<CR>

" wonder how often you hit <Esc> when already in normal mode?
" Uncomment the following line to find out. Abandon all hope.
" nnoremap <Esc> ggdG

"|    General mappings                                                      <<<
"|-----------------------------------------------------------------------------

" quick save on <Return>
noremap <silent> <CR> :up<CR><CR>

" spare one VimGolf point (and a Shift press) on :q, :w, :e, :x
noremap <Leader>q :q<CR>
noremap <Leader>w :w<CR>
noremap <Leader>e :e<CR>
noremap <Leader>x :x<CR>

" lazy code folding / unfolding
noremap <Tab>   za
noremap <S-Tab> zA
" fold stuff around selection
"vnoremap <Leader>za <Esc>`<kzfgg`>jzfG`<

iabbrev </ </<C-X><C-O>

" switching / moving / creating tabs
noremap g<Tab>   gt
noremap g<S-Tab> gT
noremap <C-Tab>   gt
noremap <C-S-Tab> gT
noremap <silent> <C-PageUp>   :exe "tabmove " .(tabpagenr()-2)<CR>
noremap <silent> <C-PageDown> :exe "tabmove " . tabpagenr()<CR>

" select the pasted text (http://vim.wikia.com/wiki/Selecting_your_pasted_text)
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" indexes the last search
nmap g/ :vimgrep /<C-r>//j %<Bar>cw<CR>

" Alt+E to open the file explorer
"noremap <silent> <M-e>  :Ex<CR>
"noremap <silent> <Esc>e :Ex<CR>
">>>

"|    Alt-* mappings                                                        <<<
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
if !exists("g:MetaSendsEscape")
  let g:MetaSendsEscape = !has("gui_running")
endif

" These Alt+[left-hand] shortcuts aren't so efficient with an AltGr layout
" but they're still much better on a laptop without right Control key...
if g:MetaSendsEscape
  noremap  <Esc>r <C-r>
  noremap  <Esc>v <C-v>
  noremap  <Esc>x <C-x>
  noremap  <Esc>a <C-a>
  " inoremap <Esc>o <C-o>
else
  noremap  <M-r> <C-r>
  noremap  <M-v> <C-v>
  noremap  <M-x> <C-x>
  noremap  <M-a> <C-a>
  " inoremap <M-o> <C-o>
endif

" Meta+[BackSpace|left|right]: word-by-word
" inoremap <Esc><BS> <C-o>dB<C-o>x
if !g:MetaSendsEscape
  map <M-Left>  <C-Left>
  map <M-Right> <C-Right>
endif

" Meta+[up|down]: paragraph-by-paragraph
noremap <C-Up>   {
noremap <C-Down> }
if !g:MetaSendsEscape
  noremap <M-Up>   {
  noremap <M-Down> }
endif

" experimental: escaped movements / on-the-fly code completion
if g:MetaSendsEscape
  "inoremap <Esc> <C-o>
  " inoremap <Esc>h <C-o>^
  " inoremap <Esc>j <C-n>
  " inoremap <Esc>k <C-p>
  " inoremap <Esc>l <C-o>$
  "inoremap <Esc>w <C-o>w
  "inoremap <Esc>e <C-o>e
  "inoremap <Esc>b <C-o>b
endif

" jump to newer/older position
if g:MetaSendsEscape
  nnoremap <Esc>n <C-i>
  nnoremap <Esc>p <C-o>
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
">>>

"|    QWERTY mappings                                                       <<<
"|-----------------------------------------------------------------------------

" lazy escape with 'kj'
"inoremap kj <Esc>`^
"cnoremap kj <Esc>`^
inoremap kj <Esc>
cnoremap kj <Esc>


"nnoremap <Esc> zz
"nnoremap <Esc><Return> zz

" switching buffers & windows
if g:MetaSendsEscape
  nnoremap <Esc>N :bn<CR>
  nnoremap <Esc>P :bp<CR>
  nnoremap <Esc>w <C-w>
  nnoremap <Esc>w<Esc>w <C-w><C-w>
else
  nnoremap <S-M-n> :bn<CR>
  nnoremap <S-M-p> :bp<CR>
  nnoremap <M-w> <C-w>
  nnoremap <M-w><M-w> <C-w><C-w>
endif

" capitalize previous word
" Note: <c-u> deletes text entered in the current line.
if g:MetaSendsEscape
  inoremap <Esc>u <C-o>b<C-o>gUw<C-o>w
  inoremap <Esc>U <C-o>B<C-o>gUW<C-o>W
else
  inoremap   <M-u> <C-o>b<C-o>gUw<C-o>w
  inoremap <S-M-u> <C-o>B<C-o>gUW<C-o>W
endif

" switching / moving / creating tabs
if g:MetaSendsEscape
  nnoremap <silent> <Esc>y :tabnew<CR>
  nnoremap <silent> <Esc>u :tabprev<CR>
  nnoremap <silent> <Esc>i :tabnext<CR>
  nnoremap <silent> <Esc>U :exe "tabmove " .(tabpagenr()-2)<CR>
  nnoremap <silent> <Esc>I :exe "tabmove " . tabpagenr()<CR>
else
  nnoremap <silent>   <M-y> :tabnew<CR>
  nnoremap <silent>   <M-u> :tabprev<CR>
  nnoremap <silent>   <M-i> :tabnext<CR>
  nnoremap <silent> <S-M-u> :exe "tabmove " .(tabpagenr()-2)<CR>
  nnoremap <silent> <S-M-i> :exe "tabmove " . tabpagenr()<CR>
endif

" scroll current window
noremap <C-j> <C-y>
noremap <C-k> <C-e>

" open a vertical split and switch over (v)
nnoremap <leader>v <C-w>v<C-w>l
nnoremap         ŭ <C-w>v<C-w>l

" open a horizontal split (s)
nnoremap <leader>v <C-w>s
nnoremap         ß <C-w>s

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

" swap ,/; in normal mode (feels more natural with my qwerty-lafayette layout)
" -- disabled because I've added that to Fanf,ingTastic; instead
" nnoremap , ;
" nnoremap ; ,
" vnoremap , ;
" vnoremap ; ,
" onoremap , ;
" onoremap ; ,
">>>

" vim: set fdm=marker fmr=<<<,>>> fdl=0:
