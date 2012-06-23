
" basic options ----------------------------------------------------------------

function! PatchZenburn()
  " make the vertical split separator look like a dar bar
  highlight VertSplit guifg=#2e3330 guibg=#2e3330
  " create a left margin by using the foldcolumn
  set foldcolumn=1
  highlight FoldColumn guibg=#3f3f3f guifg=#3f3f3f
endfunction
" patch the color scheme after it's loaded
augroup patchcolorscheme
  autocmd ColorScheme * call PatchZenburn()
augroup END

" set color scheme
colorscheme zenburn
let g:zenburn_old_Visual = 1

set showmode! " disable showmode, as powerline shows it

" clojure ----------------------------------------------------------------------

" lisp rainbow parens
let g:lisp_rainbow=1

" slimv repl syntax coloring
let g:slimv_repl_syntax = 1

" open repl in a vertical split on the right
let g:slimv_repl_split = 4

let g:slimv_ctags="/usr/local/bin/ctags -a --language-force=lisp --langmap=Lisp:+.clj"
let g:slimv_menu=1
let g:slimv_balloon=1

" commands ---------------------------------------------------------------------

":V edits vimrc
:command! V exe "e ~/.vim/vimrc"

":VD edits defaults.vim
:command! VD exe "e ~/.vim/defaults.vim"

":VC edits custom.vim
:command! VC exe "e ~/.vim/custom.vim"

":VV reloads .vimrc
:command! VV exe "w | mkview | source ~/.vimrc | filetype detect | echo 'vimrc reloaded'"

" :C opens !/.vim/cheasheet.txt
:command! C exe "e ~/.vim/cheasheet.txt"

" :H shows hidden characters
:command! H exe ":set list!"

" :Q closes all buffers
:command! Q exe ":bufdo bdelete"

" :T converts all buffers into tabs
:command! T exe ":tab sball"

" :Z strips all trailing whitespace in the current file
:command! Z exe ":%s/\s\+$// | :let @/=''"

" :S to turn on/off spell checker
:command! S exe ":set spell!"

" :U turns on/off gundo
:command! U exe ":GundoToggle"

" plugin options ---------------------------------------------------------------

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" fuzzyfinder datadir
let g:fuf_dataDir="~/.vim/tmp/fuf"

" powerline
let g:Powerline_symbols = 'fancy'
set laststatus=2

" use newer ctags from homebrew
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"

" NERDTree
let NERDChristmasTree=1
let NERDTreeMouseMode=3
let NERDTreeBookmarksFile=$HOME.'/vim/tmp/NERDTreeBookmarks'
let NERDTreeShowHidden=1
let NERDTreeDirArrows=1

" Ctrl-P
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_cache_dir = $HOME.'/.vim/tmp/ctrlp'

" nerdcommenter
let g:NERDCreateDefaultMappings = 0

" buftabs
:let g:buftabs_only_basename=1

" easytags
" let g:easytags_cmd = '/usr/local/bin/ctags'
" let g:easytags_file = '~/.vim/tmp/easytags/all'
" let g:easytags_by_filetype = '~/.vim/tmp/easytags/'
" set tags=./tags;
" let g:easytags_dynamic_files = 1

" fugitive
" use .. to open parent tree
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
" auto clean fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" neocomplcache ----------------------------------------------------------------

" disable AutoComplPop.
let g:acp_enableAtStartup = 0

" use neocomplcache.
let g:neocomplcache_enable_at_startup = 1

" use smartcase.
let g:neocomplcache_enable_smart_case = 1

" use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1

" use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1

" set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" key-mappings.
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" plugin mappings --------------------------------------------------------------

" peepopen
map <leader><space> :PeepOpen<cr><cr>

" D-p opens ctrlp files
let g:ctrlp_map = '<D-p>'

" D-l opens ctrlp buffers
nnoremap <D-b> :CtrlPBuffer<cr>

" ,a opens ACK
nnoremap <leader>a :Ack<space>

" ,g opens Grep
nnoremap <leader>g :Grep<space>

" D-y toggles nerdtree
nnoremap <D-y> :NERDTreeToggle<cr>

" \\ toggles comments
nnoremap \\ :call NERDComment("n", "toggle")<CR>
vnoremap \\ :call NERDComment("n", "toggle")<CR>gv

" Waldo
if ! exists("g:waldo_loaded")
  let g:waldo_loaded = 1
  let s:save_cpo = &cpo
  set cpo&vim
  function s:LaunchWaldoViaVim()
    let cwd = getcwd()
    silent exe  "!open -a Waldo " . shellescape(cwd)
    silent exe  "!open -a Waldo " . shellescape(cwd)
  endfunction
  command! Waldo :call <SID>LaunchWaldoViaVim()
  noremap <unique> <script> <Plug>Waldo <SID>Launch
  noremap <SID>Launch :call <SID>LaunchWaldoViaVim()<CR>
  if !hasmapto('<Plug>Waldo')
    map <unique> <silent> <Leader>f <Plug>Waldo
  endif
endif
