"|
"| File    : ~/.vim/plugins.vim
"| Author  : Fabien Cazenave
"| Source  : https://github.com/fabi1cazenave/dotFiles
"| Licence : WTFPL
"|


" rely on NeoBundle to handle most Vim plugins
" Alternative: 'tpope/vim-pathogen'
" Alternative: 'gmarik/vundle'
" Alternative: 'sunaku/vim-unbundle'
" Alternative: 'MarcWeber/vim-addon-manager'
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim' " let NeoBundle manage itself - required!


"|    Must-have bundles                                                     {{{
"|-----------------------------------------------------------------------------

NeoBundle 'mozfr/mozilla.vim'
NeoBundle 'jceb/vim-orgmode'
NeoBundle 'tpope/vim-speeddating'

" QuickFixSigns -- show markers, quickfix and VCS status
" Alternative: 'mhinz/vim-signify'
" Alternative: 'airblade/vim-gitgutter'
" Alternative: 'akiomik/git-gutter-vim'
" Alternative: 'dhruvasagar/vim-markify'
" Alternative: 'vim-scripts/ShowMarks'
set lazyredraw
let g:quickfixsigns_events = ['BufEnter', 'CursorHold', 'CursorMoved', 'InsertLeave', 'InsertChange']
NeoBundle 'tomtom/quickfixsigns_vim'

" NERD Commenter
" NeoBundle 'scrooloose/nerdcommenter'
" let g:NERDSpaceDelims = 1
" let g:NERDCustomDelimiters = {
"     \ 'javascript': { 'left': '//~ ', 'leftAlt': '/**', 'rightAlt': '*/'}
" \ }
" Alternative: 'tomtom/tcomment_vim'
" Alternative: 'tpope/vim-commentary' (simpler and more Vim-like, e.g. gcap)
NeoBundle 'tpope/vim-commentary'

" make the dot command (.) work with vim-surround, vim-commentary…
NeoBundle 'tpope/vim-repeat'

" Syntastic
" let g:syntastic_javascript_checkers = ['gjslint']
" let g:syntastic_javascript_gjslint_conf = '--nojsdoc'
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_mode_map = {
                         \   'mode': 'active',
                         \   'active_filetypes': ['javascript'],
                         \   'passive_filetypes': ['html']
                         \ }
NeoBundle 'scrooloose/syntastic.git'

" SuperTab (requires pydoc)
" Alternative: 'Shougo/neocomplcache'
" Alternative: 'Shougo/neocomplete'
" Alternative: 'Rip-Rip/clang_complete'
" Alternative: 'Valloric/YouCompleteMe'
" NeoBundle 'ervandew/supertab'
" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
" autocmd FileType python     set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = 'context'
set completeopt=menuone,longest,preview

" }}}

"|    Nice-to-have bundles                                                  {{{
"|-----------------------------------------------------------------------------

" Zen Coding (now called 'emmet-vim')
" Alternative: 'tristen/vim-sparkup'
" let g:user_zen_leader_key = '<S-Return>'
" inoremap <S-Return> <nop>
NeoBundle 'mattn/emmet-vim'

" Fanf,ingTastic; & SearchParty => easy quick movements (FfTt;,*#)
" Alternative: 'svermeulen/vim-extended-ft'
" Alternative: 'Lokaltog/vim-easymotion'
" Alternative: 'goldfeld/vim-seek'
" Warning: fanfingtastic breaks the . command unless vim-repeat is installed.
NeoBundle 'dahu/vim-fanfingtastic'
NeoBundle 'dahu/SearchParty'

" get the whole unicode description of a char with ga
NeoBundle 'tpope/vim-characterize'

" Tabular (+ table-mode, which depends on it)
NeoBundle 'godlygeek/tabular'
NeoBundle 'dhruvasagar/vim-table-mode'
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <leader>a: :Tabularize /:<CR>
nmap à= :Tabularize /=<CR>
vmap à= :Tabularize /=<CR>
nmap à: :Tabularize /:<CR>
vmap à: :Tabularize /:<CR>

"}}}

"|    Unite.vim                                                             {{{
"|-----------------------------------------------------------------------------
" http://usevim.com/2013/06/19/unite/
" http://www.codeography.com/2013/06/17/replacing-all-the-things-with-unite-vim.html
" http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
" https://github.com/bling/dotvim/blob/master/vimrc#L531-L591

" required by unite.vim for async stuff
NeoBundle 'Shougo/vimproc.vim', {
        \   'build' : {
        \     'windows' : 'make -f make_mingw32.mak',
        \     'cygwin'  : 'make -f make_cygwin.mak',
        \     'mac'     : 'make -f make_mac.mak',
        \     'unix'    : 'make -f make_unix.mak'
        \   }
        \ }

NeoBundle 'Shougo/unite.vim'

let g:unite_prompt = '» '

" content searching: use ag|ack for search
" https://coderwall.com/p/pwh5jg (“Ignoring .gitignore files in Unite.vim”)
" Alternative: 'mileszs/ack.vim'
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ack')
  let g:unite_source_grep_command = 'ack'
  let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
  let g:unite_source_grep_recursive_opt = ''
endif
nnoremap ſ :Unite grep:.<CR>

" file/buffer searching
" Alternative: 'kien/ctrlp.vim'
" Alternative: 'wincent/Command-T'
" Alternative: FuzzyFinder
NeoBundle 'Shougo/neomru.vim'
" nnoremap <C-p> :Unite file_rec/async<CR>
nnoremap è :Unite -no-split file<CR>
" nnoremap é :Unite -auto-preview buffer file file_rec/async<CR>
" nnoremap é :Unite buffer file file_rec/async<CR>
" nnoremap é :Unite -toggle -start-insert -buffer-name=mixed buffer file_mru file<CR>
" nnoremap ® :Unite -toggle -start-insert -buffer-name=files file_rec/async<CR>
nnoremap é :Unite -no-split -buffer-name=mixed buffer file_mru file<CR>
nnoremap ® :Unite -no-split -buffer-name=files file_rec/async<CR>

" buffer switching like JustyJuggler
" nnoremap <Leader>b :Unite -quick-match buffer<CR>

" yank history
" Alternative: 'vim-scripts/YankRing.vim'
" Alternative: 'maxbrunsfeld/vim-yankstack'
let g:unite_source_history_yank_enable = 1
nnoremap † :Unite history/yank<CR>

" Plugin: source outliner
NeoBundle 'h1mesuke/unite-outline'
nnoremap þ :Unite outline<CR>

" Plugin: file explorer
" Alternative: 'tpope/vim-vinegar'
" Alternative: 'scrooloose/nerdtree'
let g:vimfiler_as_default_explorer = 1
NeoBundle 'Shougo/vimfiler.vim'
nnoremap æ :VimFiler<CR>
"}}}

"|    Bundles under test :: tupperVim-14.10                                 {{{
"|-----------------------------------------------------------------------------
NeoBundle 'tpope/vim-eunuch'

" + Ranger:
"   • !shell %s
"   • commandes perso
"   • nouveautés 1.6.1
"   • alias conditionnel `lr'
"   • pré-visu images
"
" + vifm 0.7.7
"
"}}}

"|    Bundles under test :: tupperVim-14.03                                 {{{
"|-----------------------------------------------------------------------------

" Astuce du mois: ouvrir avec :sp [fichier] ou :vs [fichier]

" This works but always selects the last tab when Vim is resized:
" autocmd VimResized * tabdo wincmd =
function! AutoResizeWindows()
  let tabnr = tabpagenr()
  tabdo wincmd =
  exe "tabnext " . tabnr
endfunction
augroup resizeGroup
  autocmd VimResized * call AutoResizeWindows()
augroup END

" http://localhost/doc/git-cheatsheet/

" JSON candy — try gqaj
" NeoBundle 'tpope/vim-jdaddy'

" nested text objects — expand with Enter, reduce with BS
" NeoBundle 'gcmt/wildfire.vim'

" Live browser editing for Vim:
" NeoBundle 'jaxbot/brolink.vim'
" https://github.com/jaxbot/brolink.vim

"}}}

"|    Bundles under test :: tupperVim-14.02                                 {{{
"|-----------------------------------------------------------------------------

NeoBundle 'marijnh/tern_for_vim'
NeoBundle 'Valloric/YouCompleteMe'

" shiny status bar
NeoBundle 'bling/vim-airline'
" Alternative: 'itchyny/lightline.vim'
" Alternative: 'Lokaltog/powerline'
let g:airline_left_sep=''
let g:airline_right_sep=''
" let g:airline_left_sep='⮀'
" let g:airline_right_sep='⮂'
" let g:airline_symbols.branch   = '⭠'
" let g:airline_symbols.readonly = '⭤'
" let g:airline_symbols.linenr   = '⭡'

"}}}

"|    Bundles under test :: tupperVim-14.01                                 {{{
"|-----------------------------------------------------------------------------

" Focus.vim
" default binding: <leader>fmt
" Note: all folds are closed again when leaving the “Focus” mode
nmap <Esc>F <Plug>FocusModeToggle
NeoBundle 'merlinrebrovic/focus.vim'

" Vim-CtrlSpace
" not sure how this one works...
" NeoBundle 'szw/vim-ctrlspace'

" NeoBundle 'wakatime/vim-wakatime'
" }}}

"|    Bundles under test :: tupperVim-1310                                  {{{
"|-----------------------------------------------------------------------------

" Git source for Unite
" NeoBundle 'kmnk/vim-unite-giti'

" colorscheme with dark/bright backgrounds
NeoBundle 'Pychimp/vim-sol'
NeoBundle 'Pychimp/vim-luna'
"}}}

"|    Bundles under test :: tupperVim-1309                                  {{{
"|-----------------------------------------------------------------------------

NeoBundle 'sotte/presenting.vim'

"}}}

"|    Bundles under test                                                    {{{
"|-----------------------------------------------------------------------------

" Decent JSON support
NeoBundle 'elzr/vim-json'

" SublimeText-like multiple cursors
NeoBundle 'terryma/vim-multiple-cursors'

" expand/shrink the active selection with +/_
NeoBundle 'terryma/vim-expand-region'

" not working as-is -- probably misses some configuration
NeoBundle 'vim-scripts/closetag.vim'

" some day, I’ll learn to use those
NeoBundle 'matchit.zip'
NeoBundle 'tpope/vim-surround'

" NeoBundle 'kien/ctrlp.vim'
" Alternative: 'Shougo/unite.vim'
" let g:ctrlp_cmd = 'CtrlPMixed'
" let g:ctrlp_map = '<C-p>'
" set runtimepath^=$VIMHOME/bundle/ctrlp.vim
" nmap <silent> ñ :CtrlP<CR>
" nmap <silent> µ :CtrlPMixed<CR>

" search with ack|ag
" Alternative: 'Shougo/unite.vim'
" let g:ackprg = 'ack-grep'
" let g:ackprg = 'ag --nogroup --nocolor --column'
" NeoBundle 'mileszs/ack.vim'
" noremap <Leader>f :Ack
" noremap ſ :Ack

" Conque Term
" Alternative: 'Shougo/vimshell.vim'
" Assign Alt-Return to a new Conque Term like in dwm/wmii/i3
" warning: with xterm you'll have to disable Alt-Return first by adding these
"          two lines to your ~/.Xresources file:
" XTerm*fullscreen      : never
" XTerm*omitTranslation : fullscreen
" NeoBundle 'chilicuil/conque'
" map <silent> <Esc><Return> :ConqueTermSplit bash<CR>
" map <silent> g<Return> :ConqueTermSplit bash<CR>

" gundo: undo tree view
" Alternative: 'mbbill/undotree'
" NeoBundle 'sjl/gundo.vim'

"}}}

"|    Bundles to be tested                                                  {{{
"|-----------------------------------------------------------------------------

"NeoBundle 'aaronbieber/quicktask'
"NeoBundle 'bufexplorer.zip'
"NeoBundle 'majutsushi/tagbar'
"NeoBundle 'mhinz/vim-tmuxify'
"NeoBundle 'msanders/snipmate.vim '
"NeoBundle 'Shougo/neosnippet.vim'
"NeoBundle 'sjl/clam.vim'
"NeoBundle 'spolu/dwm.vim'
"NeoBundle 'tpope/vim-dispatch'
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'tpope/vim-obsession'
"NeoBundle 'tpope/vim-sleuth'
"NeoBundle 'tpope/vim-speeddating'
"NeoBundle 'tpope/vim-tbone'
"NeoBundle 'tpope/vim-unimpaired'
"NeoBundle 'vim-scripts/inline_edit.vim'
"NeoBundle 'vim-scripts/snippetsEmu'
"NeoBundle 'vim-scripts/vcscommand.vim'
"NeoBundle 'vim-scripts/ZoomWin'
"NeoBundle 'wikitopian/hardmode'
"}}}

" vim: set fdm=marker fmr={{{,}}} fdl=0:
