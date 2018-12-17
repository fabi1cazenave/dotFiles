"|
"| File    : ~/.config/nvim/plugins.vim
"| Author  : Fabien Cazenave
"| Source  : https://github.com/fabi1cazenave/dotFiles
"| Licence : WTFPL
"|

autocmd! FileType     startify    setlocal foldmethod=manual
autocmd! FileType     help        setlocal foldmethod=manual
autocmd! FileType     vim-plug    setlocal foldmethod=manual nonumber
autocmd! bufwritepost plugins.vim source %

" 'junegunn/vim-plug' = bullet-proof plugin management. Manually installed in:
"   ~/.config/nvim/autoload/plug.vim
" Alternative: 'tpope/vim-pathogen'
" Alternative: 'gmarik/vundle'
" Alternative: 'Shougo/neobundle.vim'
" Alternative: 'sunaku/vim-unbundle'
" Alternative: 'MarcWeber/vim-addon-manager'
call plug#begin('~/.config/nvim/bundle/')

"|    Basic Features                                                        {{{
"|-----------------------------------------------------------------------------

" In Tim Pope we trust.
Plug 'tpope/vim-surround'        " quoting/parenthesizing made simple
Plug 'tpope/vim-repeat'          " required to support `.` with some plugins
Plug 'tpope/vim-characterize'    " `ga` gets the Unicode description of a char
Plug 'tpope/vim-commentary'      " toggle comments easily

" CUA: adjusting the balance between Vim and standard shortcuts,
" i.e. make Ctrl-ZXCV and Ctrl-arrows work as expected.
Plug 'fabi1cazenave/cua-mode.vim'
behave xterm                     " possible values: xterm, mswin
let g:cua_mode   = 1             " standard Vim shortcuts + CTRL-ZXCV
let g:cua_arrows = 0             " disable arrow keys (badass mode!)

" wmii/i3-like window management
" Alternative: 'jceb/vmux'
Plug 'fabi1cazenave/suckless.vim'
let g:suckless_tmap = 1
let g:suckless_mappings = {
\        '<M-[sdf]>'      :   'SetTilingMode("[sdf]")'    ,
\        '<M-[hjkl]>'     :    'SelectWindow("[hjkl]")'   ,
\        '<M-[HJKL]>'     :      'MoveWindow("[hjkl]")'   ,
\      '<C-M-[hjkl]>'     :    'ResizeWindow("[hjkl]")'   ,
\        '<M-[oO]>'       :    'CreateWindow("[sv]")'     ,
\        '<M-w>'          :     'CloseWindow()'           ,
\      '<C-M-w>'          :  'CollapseWindow()'           ,
\        '<M-y>'          :       'CreateTab()'           ,
\        '<M-[UI]>'       :         'MoveTab("[hl]")'     ,
\        '<M-[ui]>'       :       'SelectTab("[hl]")'     ,
\        '<M-[123456789]>':       'SelectTab([123456789])',
\        '<M-[!@#$%^&*(]>': 'MoveWindowToTab([123456789])',
\}
set splitbelow " consistency with most tiling WMs (wmii, i3…)
set splitright " consistency with most tiling WMs (wmii, i3…)

" highlight the yanked region
Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 200

" skip folds when navigating with { and }
Plug 'justinmk/vim-ipmotion'
let g:ip_skipfold = 1

" Automatically clears search highlight when cursor is moved.
" Improved star-search (visual-mode, highlighting without moving).
" Alternative: 'romainl/vim-cool'
Plug 'junegunn/vim-slash'

" vertical alignment
Plug 'junegunn/vim-easy-align'
xmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

" Smooth scrolling
" Alternative: 'yuttie/comfortable-motion.vim'
Plug 'terryma/vim-smooth-scroll' " {{{
noremap <silent> <c-u>       :call smooth_scroll#up  (&scroll,   0, 2)<CR>
noremap <silent> <c-d>       :call smooth_scroll#down(&scroll,   0, 2)<CR>
noremap <silent> <c-b>       :call smooth_scroll#up  (&scroll*2, 0, 4)<CR>
noremap <silent> <c-f>       :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
noremap <silent> <Backspace> :call smooth_scroll#up  (&scroll*2, 0, 4)<CR>
noremap <silent> <Space>     :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
" }}}

" start screen
Plug 'mhinz/vim-startify'
" }}}

"|    Color Schemes                                                         {{{
"|-----------------------------------------------------------------------------

" dark themes
Plug 'nanotech/jellybeans.vim'
Plug 'tomasr/molokai'
Plug 'mhinz/vim-janah'
Plug 'fcpg/vim-fahrenheit'
Plug 'marfisc/vorange'
Plug 'jacoborus/tender.vim'
" XXX not working with Neovim
" Plug 'zenorocha/dracula-theme'

" suitable themes for dark/light backgrounds, just set bg accordingly:
"    :set background=[dark|light]
Plug 'fabi1cazenave/kalahari.vim'
Plug 'rakr/vim-one'
Plug 'rakr/vim-two-firewatch'
Plug 'junegunn/seoul256.vim'
Plug 'noahfrederick/vim-hemisu'
Plug 'freeo/vim-kalisi'
Plug 'zanglg/nova.vim'
Plug 'MvanDiemen/ghostbuster'
Plug 'chmllr/elrodeo-vim-colorscheme' " low-contrast `ghostbuster` variant
Plug 'lifepillar/vim-solarized8'      " working `solarized` variant for Neovim
" XXX not working with Neovim
" Plug 'altercation/vim-colors-solarized'
" Plug 'Slava/vim-colors-tomorrow'    " `solarized` variant
" Plug 'jsit/disco.vim'

" Background Switchers {{{
function! ToggleBackground()
  let &background = (&background == 'light' ? 'dark' : 'light')
  set background? " display the current background setting
endfunction
nmap <silent><M-\> :call ToggleBackground()<CR>

" works fine with pywal on Linux, otherwise useless (and hopefully harmless)
function! AutoBackground()
  let l:bg = split(system('xrdb -query | grep background'), '\n')[0]
  let l:color = split(l:bg, '#')[1]
  if strlen(l:color) == 6 " false if the `xrdb` command has failed
    let l:dark = 0
    for i in [0, 2, 4]
      let l:dark += str2nr(l:color[i:i+1], 16) < 128 ? 1 : -1
    endfor
    let &background = (l:dark > 0 ? 'dark' : 'light')
  endif
endfunction
call AutoBackground()

" automatically switches between dark & light backgrounds
" Plug 'amdt/sunset'
" let g:sunset_utc_offset = 0 " London
" let g:sunset_latitude   = 51.5
" let g:sunset_longitude  = -0.1167
" }}}
" }}}

"|    Software Development                                                  {{{
"|-----------------------------------------------------------------------------

" all language packs, async’ed
Plug 'sheerun/vim-polyglot'

" Being a good citizen
Plug 'editorconfig/editorconfig-vim'

" Linter + Fixer + Auto-Complete, async’ed
" Alternative: 'benekastah/neomake'
Plug 'w0rp/ale' " {{{

" linters
let g:ale_linters = {
\   'html':       ['prettier'],
\   'javascript': ['prettier', 'eslint'],
\   'css':        ['csslint'],
\   'stylus':     [],
\}
" let g:ale_stylus_stylelint_executable = 'stylint'
" call ale#linter#Define('stylus', {
" \   'name': 'stylint',
" \   'executable': 'stylint',
" \   'command': g:ale#util#stdin_wrapper . ' .styl stylint',
" \   'callback': 'ale#handlers#HandleCSSLintFormat',
" \})
" let g:ale_linters = {
" \   'html':       ['prettier'],
" \   'javascript': ['prettier', 'eslint'],
" \   'css':        ['stylint', 'csslint'],
" \   'stylus':     ['stylint'],
" \}
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" fixers
" let g:ale_fix_on_save = 1 " off by default
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'css':        ['stylelint'],
\   'stylus':     ['stylelint'],
\}
nmap <silent> g= :ALEFix<CR>
" }}}

" Elm
Plug 'ElmCast/elm-vim'
let g:elm_format_autosave = 1

" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
" For example, with the following mappings you can navigate to the identifier
" under the cursor and open it on the current buffer, on an horizontal or
" vertical split, or go straight to the documentation:
" au FileType rust nmap gd <Plug>(rust-def)
" au FileType rust nmap gs <Plug>(rust-def-split)
" au FileType rust nmap gx <Plug>(rust-def-vertical)
" au FileType rust nmap <leader>gd <Plug>(rust-doc)

" Nice `git commit` integration
" Alternative: `git commit -v`
Plug 'rhysd/committia.vim'
" }}}

"|    Text Objects                                                          {{{
"|-----------------------------------------------------------------------------

" Text objects, folding, and more for Python and other indented languages.
Plug 'tweekmonster/braceless.vim'

Plug 'kana/vim-operator-user' | Plug 'haya14busa/vim-operator-flashy'

" Default mappings
" am: around method call.       Gets the method call of the surrounding scope.
" im: inner method call.        Gets the method call of the current scope.
" aM: around method call chain. Gets the method call chain of the surrounding scope.
" iM: inner method call chain.  Gets the method call chain of the current scope.
Plug 'kana/vim-textobj-user' | Plug 'thalesmello/vim-textobj-methodcall'

" targets.vim: new text objects (nice with vim-exchange and surround)
" }}}

"|    File / Buffer Browsers                                                {{{
"|-----------------------------------------------------------------------------

" Quick file access:
" Alternative: 'scrooloose/nerdtree'
" Alternative: 'justinmk/vim-dirvish'
" Alternative: 'yegappan/mru'
" Alternative: 'francoiscabrol/ranger.vim' | Plug 'rbgrouleff/bclose.vim'
" Alternative: 'ptzz/lf.vim'
Alternative: 'fabi1cazenave/termopen.vim'
if has('nvim')
  let g:termopen_mappings = 0
  nnoremap <silent>   <M-Return> :call TermOpen()<CR>
  nnoremap <silent> <S-M-Return> :call TermOpenRanger()<CR>
  tnoremap            <M-Return> <C-\><C-n>
else
  nnoremap <silent> <Leader>f :call TermOpenRanger()<CR>
endif

" In junegunn we trust, too.
" see https://github.com/junegunn/fzf#git-ls-tree-for-fast-traversal
" Alternative: 'Shougo/denite.nvim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " {{{
nmap <leader>r :Files<CR>
nmap <leader>g :GFiles<CR>
nmap <leader><tab> <plug>(fzf-maps-n)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" custom FZF statusline when started in a :term
" function! s:fzf_statusline()
"   highlight fzf1 ctermfg=161 ctermbg=251
"   highlight fzf2 ctermfg=23  ctermbg=251
"   highlight fzf3 ctermfg=237 ctermbg=251
"   setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
" endfunction
" autocmd! User FzfStatusLine call <SID>fzf_statusline()

" }}}

" }}}

" Authoring
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'suan/vim-instant-markdown'

" add plugins to &runtimepath and enable syntax highlighting
call plug#end()
colorscheme kalahari

" vim: set ft=vim fdm=marker fmr={{{,}}} fdl=0:
