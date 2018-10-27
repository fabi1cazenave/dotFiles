" Enter the terminal in insert mode
autocmd BufEnter term://* startinsert

" Exit built-in terminal (same shortcut as my tmux prefix)
tnoremap <A-Space> <C-\><C-n>

" This is perfect for regular shell commands but a PITA with interactive apps
" tnoremap kj <C-\><C-n>

" This does not work, unfortunately :-(
tnoremap <A-h> <C-\><C-n><A-h>
tnoremap <A-j> <C-\><C-n><A-j>
tnoremap <A-k> <C-\><C-n><A-k>
tnoremap <A-l> <C-\><C-n><A-l>

" Kalahari term color theme (copied from my ~/.Xresources)
" 0: black
let g:terminal_color_0  = '#000000'
let g:terminal_color_8  = '#666666'
" 1: red
let g:terminal_color_1  = '#cc7777'
let g:terminal_color_9  = '#cf6171'
" 2: green
let g:terminal_color_2  = '#00cd00'
let g:terminal_color_10 = '#c5f779'
" 3: yellow
let g:terminal_color_3  = '#ffbb66'
let g:terminal_color_11 = '#fff796'
" 4: blue
let g:terminal_color_4  = '#22aa99'
let g:terminal_color_12 = '#bbbbff'
" 5: magenta
let g:terminal_color_5  = '#ff66cc'
let g:terminal_color_13 = '#f935f9'
" 6: cyan
let g:terminal_color_6  = '#88bbbb'
let g:terminal_color_14 = '#14f0f0'
" 7: white
let g:terminal_color_7  = '#eeeedd'
let g:terminal_color_15 = '#ffffee'

