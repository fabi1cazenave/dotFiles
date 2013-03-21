"|
"| File    : ~/.vim/plugins.vim
"| Source  : https://github.com/fabi1cazenave/dotFiles
"| Licence : WTFPL
"|


" rely on Vundle to handle most Vim plugins
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle - required!
Bundle 'gmarik/vundle'


"|    Must-have bundles                                                     <<<
"|-----------------------------------------------------------------------------

Bundle 'mozfr/mozilla.vim'
Bundle 'jceb/vim-orgmode'

" NERD Commenter
let g:NERDSpaceDelims = 1
" let g:NERDCustomDelimiters = {
"     \ 'javascript': { 'left': '//~ ', 'leftAlt': '/**', 'rightAlt': '*/'}
" \ }
Bundle 'scrooloose/nerdcommenter'

" Syntastic
let g:syntastic_javascript_checker = 'gjslint'
let g:syntastic_javascript_gjslint_conf = "--nojsdoc"
let g:syntastic_mode_map = { 'mode': 'active',
  \ 'active_filetypes': ['javascript'],
  \ 'passive_filetypes': ['html'] }
Bundle 'scrooloose/syntastic.git'

" SuperTab (requires pydoc)
" alternative: 'Valloric/YouCompleteMe'
Bundle 'ervandew/supertab'
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
autocmd FileType python     set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = 'context'
set completeopt=menuone,longest,preview
" >>>

"|    Nice-to-have bundles                                                  <<<
"|-----------------------------------------------------------------------------

" Zen Coding
let g:user_zen_leader_key = '<S-Return>'
Bundle 'mattn/zencoding-vim'

" Ack
"let g:ackprg = 'ack-grep'
let g:ackprg = 'ag --nogroup --nocolor --column'
Bundle 'mileszs/ack.vim'
noremap <Leader>f :Ack 
noremap ſ :Ack 

" Tabular (+ table-mode, which depends on it)
Bundle 'godlygeek/tabular'
Bundle 'dhruvasagar/vim-table-mode'
" if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:<CR>
  vmap <leader>a: :Tabularize /:<CR>
  nmap à= :Tabularize /=<CR>
  vmap à= :Tabularize /=<CR>
  nmap à: :Tabularize /:<CR>
  vmap à: :Tabularize /:<CR>
" endif

" Conque Term
" Assign Alt-Return to a new Conque Term like in dwm/wmii/i3
" warning: with xterm you'll have to disable Alt-Return first by adding these
"          two lines to your ~/.Xresources file:
" XTerm*fullscreen      : never
" XTerm*omitTranslation : fullscreen
" map <silent> <Esc><Return> :ConqueTermSplit bash<CR>
" Bundle 'chilicuil/conque'
" map <silent> g<Return> :ConqueTermSplit bash<CR>

"Bundle 'sjl/gundo.vim'
">>>

"|    Bundles under test :: tupperVim-1303                                  <<<
"|-----------------------------------------------------------------------------

" Fanf,ingTastic; & SearchParty => easy quick movements (FfTt;,*#)
" see also: Lokaltog/vim-easymotion, goldfeld/vim-seek
Bundle 'dahu/vim-fanfingtastic'
Bundle 'dahu/SearchParty'

" QuickFixSigns -- show markers, quickfix and VCS status
Bundle 'tomtom/quickfixsigns_vim'

"Bundle 'tpope/vim-fugitive'
"Bundle 'tpope/vim-sleuth'
"Bundle 'majutsushi/tagbar'

" not working as-is -- probably misses some configuration
Bundle 'vim-scripts/closetag.vim'

">>>

"|    Bundles under test :: tupperVim-1302                                  <<<
"|-----------------------------------------------------------------------------

Bundle 'matchit.zip'
Bundle 'surround.vim'

Bundle 'kien/ctrlp.vim'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_map = '<C-p>'
set runtimepath^=~/.vim/bundle/ctrlp.vim
nmap <silent> ñ :CtrlP<CR>
nmap <silent> µ :CtrlPMixed<CR>
">>>

"|    Bundles to be tested                                                  <<<
"|-----------------------------------------------------------------------------

"Bundle 'aaronbieber/quicktask'
"Bundle 'mbbill/undotree'
"Bundle 'bufexplorer.zip'
"Bundle 'vim-scripts/inline_edit.vim'
">>>

" vim: set fdm=marker fmr=<<<,>>> fdl=0:
