"|
"| File    : ~/.vim/mappings
"| Source  : https://github.com/fabi1cazenave/dotFiles
"| Licence : WTFPL
"|


" disable digraph input to make ^ work faster
set nodigraph

"|    General mappings                                                      <<<
"|-----------------------------------------------------------------------------

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

" experimental: escaped movements / on-the-fly code completion
"inoremap <Esc> <C-o>
inoremap <Esc>h <C-o>^
inoremap <Esc>j <C-n>
inoremap <Esc>k <C-p>
inoremap <Esc>l <C-o>$
"inoremap <Esc>w <C-o>w
"inoremap <Esc>e <C-o>e
"inoremap <Esc>b <C-o>b

" jump to newer/older position
noremap <Esc>n <C-i>
noremap <Esc>p <C-o>

" lazy command-line history: hold down Meta, dot, j|k
noremap <Esc>. :
cnoremap <Esc>j <Down>
cnoremap <Esc>k <Up>
">>>

"|    QWERTY mappings                                                       <<<
"|-----------------------------------------------------------------------------

" lazy escape with 'kj'
"inoremap kj <Esc>`^
"cnoremap kj <Esc>`^
inoremap kj <Esc>
cnoremap kj <Esc>

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
noremap <Esc>N :bn<CR>
noremap <Esc>P :bp<CR>
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

" scroll current window
" noremap <C-j> <C-y>
" noremap <C-k> <C-e>

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
"nnoremap , ;
"nnoremap ; ,
"vnoremap , ;
"vnoremap ; ,
"onoremap , ;
"onoremap ; ,
">>>

" vim: set fdm=marker fmr=<<<,>>> fdl=0:
