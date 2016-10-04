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

"|    Basic features                                                        {{{
"|-----------------------------------------------------------------------------

" In Tim Pope we trust.
Plug 'tpope/vim-surround'        " quoting/parenthesizing made simple
Plug 'tpope/vim-commentary'      " toggle comments easily
Plug 'tpope/vim-repeat'          " required to support `.` with some plugins
Plug 'tpope/vim-characterize'    " `ga` gets the Unicode description of a char

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

" Triggers code linters asynchronously when the buffer is saved
"   :lopen / :lclose   open/close the location window
"   :lnext / :lprev    jump to the next/previous error
"   :ll                jump to the current error
Plug 'benekastah/neomake'
let g:neomake_javascript_enabled_makers = ['eslint', 'jshint']
augroup neomake
  autocmd! BufWritePost * Neomake
augroup

" Perfect `git commit` integration
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

" automatically switches between dark & light backgrounds
" Plug 'amdt/sunset'
" let g:sunset_utc_offset = 0 " London
" let g:sunset_latitude   = 51.5
" let g:sunset_longitude  = -0.1167

"}}}

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

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

" in junegunne we trust, too.
" see https://github.com/junegunn/fzf#git-ls-tree-for-fast-traversal
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
nmap <leader>f :FZF<CR>
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

colorscheme jellybeans

" vim: set ft=vim fdm=marker fmr={{{,}}} fdl=0:
