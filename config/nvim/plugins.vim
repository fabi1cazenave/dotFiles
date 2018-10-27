"|
"| File    : ~/.config/nvim/plugins.vim
"| Author  : Fabien Cazenave
"| Source  : https://github.com/fabi1cazenave/dotFiles
"| Licence : WTFPL
"|

autocmd FileType startify set foldmethod=marker

" vim-plug provides an idiot-proof plugin management. Manually installed in:
"   ~/.config/nvim/autoload/plug.vim
" Alternative: 'tpope/vim-pathogen'
" Alternative: 'gmarik/vundle'
" Alternative: 'Shougo/neobundle.vim'
" Alternative: 'sunaku/vim-unbundle'
" Alternative: 'MarcWeber/vim-addon-manager'
" Alternative: 'junegunn/vim-plug'
call plug#begin('~/.config/nvim/bundle/')

" next tupperVim:
" sudo sysctl vm.swappiness=0
" see https://askubuntu.com/questions/235146/why-does-ubuntu-use-swap-when-there-is-enough-free-memory

" to check:
" deoplete + LSP
" denite instead of FZF
" vim-sneak to get a 2-char f/t search
" targets.vim: new text objects (nice with vim-exchange and surround)

" Smooth scrolling
" Alternative: 'yuttie/comfortable-motion.vim'
Plug 'terryma/vim-smooth-scroll'
noremap <silent> <c-u>       :call smooth_scroll#up  (&scroll,   0, 2)<CR>
noremap <silent> <c-d>       :call smooth_scroll#down(&scroll,   0, 2)<CR>
noremap <silent> <c-b>       :call smooth_scroll#up  (&scroll*2, 0, 4)<CR>
noremap <silent> <c-f>       :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
noremap <silent> <Backspace> :call smooth_scroll#up  (&scroll*2, 0, 4)<CR>
noremap <silent> <Space>     :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" tupperVim juillet Grenoble
" BufferGator

" " requires Ruby 2.0+
" " gem install mdn_query
" Plug 'jungomi/vim-mdnquery'
" " :MdnQuery array remove
" " :MdnQueryFirstMatch array.pop
" autocmd FileType html setlocal keywordprg=:MdnQueryFirstMatch

" Plug 'Tehnix/spaceneovim'

" disables search highlighting when you are done searching
" and re-enables it when you search again
" Plug 'romainl/vim-cool'
" Automatically clears search highlight when cursor is moved
" Improved star-search (visual-mode, highlighting without moving)
Plug 'junegunn/vim-slash'

Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 200

" tupperVim 17-02
Plug 'romainl/vim-qf'

" romain.lafourcade@digitaslbi.fr

Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
" For example, with the following mappings you can navigate to the identifier
" under the cursor and open it on the current buffer, on an horizontal or
" vertical split, or go straight to the documentation:
" au FileType rust nmap gd <Plug>(rust-def)
" au FileType rust nmap gs <Plug>(rust-def-split)
" au FileType rust nmap gx <Plug>(rust-def-vertical)
" au FileType rust nmap <leader>gd <Plug>(rust-doc)

"|    Basic features                                                        {{{
"|-----------------------------------------------------------------------------

" In Tim Pope we trust.
Plug 'tpope/vim-surround'        " quoting/parenthesizing made simple
Plug 'tpope/vim-repeat'          " required to support `.` with some plugins
Plug 'tpope/vim-characterize'    " `ga` gets the Unicode description of a char
Plug 'tpope/vim-commentary'      " toggle comments easily

" CUA: adjusting the balance between Vim and standard shortcuts,
" i.e. make Ctrl-ZXCV and Ctrl-arrows work as expected.
Plug '~/Documents/vimFiles/cua-mode.vim' " local working directory
" Plug 'fabi1cazenave/cua-mode.vim'
behave xterm                     " possible values: xterm, mswin
let g:cua_mode   = 1             " standard Vim shortcuts + CTRL-ZXCV
let g:cua_arrows = 0             " disable arrow keys (badass mode!)

" wmii/i3-like window management — requires `g:MetaSendsEscape = 0` on Neovim
Plug '~/Documents/vimFiles/suckless.vim' " local working directory
" Plug 'fabi1cazenave/suckless.vim'
set splitbelow                   " consistency with most tiling WMs (wmii, i3…)
set splitright                   " consistency with most tiling WMs (wmii, i3…)

"}}}

"|    Web Development                                                       {{{
"|-----------------------------------------------------------------------------

" Up-to-date HTML5+JS support
Plug 'othree/html5.vim'
Plug 'othree/yajs.vim'

" " Triggers code linters asynchronously when the buffer is saved
" "   :lopen / :lclose   open/close the location window
" "   :lnext / :lprev    jump to the next/previous error
" "   :ll                jump to the current error
" Plug 'benekastah/neomake'
" let g:neomake_javascript_enabled_makers = ['eslint', 'jshint']
" augroup neomake
"   autocmd! BufWritePost * Neomake
" augroup

Plug 'w0rp/ale'
" After this is configured, :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
" let g:ale_fix_on_save = 1 " off by default

" Nice `git commit` integration
Plug 'rhysd/committia.vim'

"}}}

"|    Color schemes                                                         {{{
"|-----------------------------------------------------------------------------

" dark themes
Plug 'fabi1cazenave/kalahari.vim'   " variation of `desert`
Plug 'nanotech/jellybeans.vim'      " nice one!
Plug 'tomasr/molokai'
Plug 'mhinz/vim-janah'
Plug 'fcpg/vim-fahrenheit'
Plug 'marfisc/vorange'
Plug 'jacoborus/tender.vim'

" Plug 'zenorocha/dracula-theme'      " XXX not working with Neovim

" Color schemes suitable for dark/light backgrounds, just set bg accordingly:
"    :set background=[dark|light]
" Plug 'altercation/vim-colors-solarized' " XXX not working with Neovim
" Plug 'Slava/vim-colors-tomorrow'        " `solarized` variant, not working with Neovim
Plug 'rakr/vim-one'
Plug 'rakr/vim-two-firewatch'
Plug 'noahfrederick/vim-hemisu'
Plug 'freeo/vim-kalisi'
Plug 'zanglg/nova.vim'
Plug 'MvanDiemen/ghostbuster'
Plug 'chmllr/elrodeo-vim-colorscheme' " low-contrast `ghostbuster` variant
" Plug 'jsit/disco.vim'               " ugly / not working with Neovim

" automatically switches between dark & light backgrounds
" Plug 'amdt/sunset'
" let g:sunset_utc_offset = 0 " London
" let g:sunset_latitude   = 51.5
" let g:sunset_longitude  = -0.1167

"}}}

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'suan/vim-instant-markdown'

Plug 'ElmCast/elm-vim'
let g:elm_format_autosave = 1

" tupperVim 16-10 {{{
Plug 'sheerun/vim-polyglot'

" }}}

" tupperVim 16-09 {{{

" looks pretty neat, gotta test
" Plug 'jceb/vmux'

" Text objects, folding, and more for Python and other indented languages.
Plug 'tweekmonster/braceless.vim'

Plug 'kana/vim-operator-user' | Plug 'haya14busa/vim-operator-flashy'

" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! w !sudo tee > /dev/null %

" Default mappings
" am: around method call.       Gets the method call of the surrounding scope.
" im: inner method call.        Gets the method call of the current scope.
" aM: around method call chain. Gets the method call chain of the surrounding scope.
" iM: inner method call chain.  Gets the method call chain of the current scope.
Plug 'kana/vim-textobj-user' | Plug 'thalesmello/vim-textobj-methodcall'

" }}}

" skip folds when navigating with { and }
Plug 'justinmk/vim-ipmotion'
let g:ip_skipfold = 1

" tupperVim 1605
Plug 'mhinz/vim-startify'

" Best use I can think of for Neovim’s :term
Plug 'francoiscabrol/ranger.vim'

" in junegunne we trust, too.
" see https://github.com/junegunn/fzf#git-ls-tree-for-fast-traversal
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nmap <leader>r :Files<CR>
nmap <leader>g :GFiles<CR>
nmap <leader><tab> <plug>(fzf-maps-n)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()

Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'

" tupperVim 1603
" Plug 'yegappan/mru'

" tupperVim 1602
" Plug 'justinmk/vim-dirvish'

" add plugins to &runtimepath and enable syntax highlighting
call plug#end()

" colorscheme jellybeans
colorscheme two-firewatch

function BackgroundSwitch()
  if &background == "light"
    set background=dark
  else
    set background=light
  endif
endfunction
nmap <silent><F12> :call BackgroundSwitch()<CR>
set background=dark

" vim: set ft=vim fdm=marker fmr={{{,}}} fdl=0:
