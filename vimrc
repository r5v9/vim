
" Bundles ---------------------------------------------------------------- {{{

" gets rid of all the crap that Vim does to be vi compatible
set nocompatible

filetype off  

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/EasyGrep'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/buftabs'
Bundle 'vim-scripts/AutoTag'
Bundle 'vim-scripts/ScrollColors'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neocomplcache-snippets-complete'
Bundle 'kien/ctrlp.vim'
Bundle 'timcharper/textile.vim'
Bundle 'godlygeek/tabular'
Bundle 'tsaleh/vim-matchit'
Bundle 'Lokaltog/vim-powerline'
Bundle 'ton/vim-bufsurf'
Bundle 'shemerey/vim-peepopen'
Bundle 'mileszs/ack.vim'

" color schemes
Bundle 'Zenburn'
Bundle 'molokai'

if has("python")
  Bundle 'sjl/gundo.vim'
  Bundle 'mbadran/headlights'
  Bundle 'vim-scripts/slimv.vim'
endif

filetype plugin indent on

" }}}

" Basic options ----------------------------------------------------------- {{{

" patch the color scheme after it's loaded
augroup patchcolorscheme
  autocmd ColorScheme * highlight VertSplit guifg=#2e3330 guibg=#2e3330
augroup END

" set color scheme
colorscheme zenburn
let g:zenburn_old_Visual = 1

" prevents some security exploits having to do with modelines in files
" see http://lists.alioth.debian.org/pipermail/pkg-vim-maintainers/2007-June/004020.html
set modelines=0

" tab setttings. expand tabs to spaces, use width 2
" see http://vimcasts.org/episodes/tabs-and-spaces/
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" fold settings
set foldmethod=syntax
set foldlevelstart=20

" autoreload files if changed externally
:set autoread

" just make things better
set encoding=utf-8
set scrolloff=1
set autoindent
set showmode! " disable showmode, as powerline shows it
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set nonumber

" ignore binary files
set wildignore+=*.o,*.obj,.git,*.class,*.jar,*.pyc

" use , as the leader key
let mapleader = ","
let maplocalleader = "\\"

" fix broken default regex handling by automatically inserting a \v before any string you search for
"nnoremap / /\v
"vnoremap / /\v

" if you search for an all-lowercase string your search will be case-insensitive, but if one or more characters is uppercase the search will be case-sensitive
set ignorecase
set smartcase

" applies substitutions globally on lines (s/../../g by default)
set gdefault

" highlight search results as you type
set incsearch
set showmatch
set hlsearch

" disable blinking cursor
" set gcr=a:blinkwait0,a:block-cursor

" handle long lines
"set wrap
"set textwidth=120
"set formatoptions=qrn1
"set colorcolumn=120

" Set region to British English
"set spelllang=en_gb

" use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" folders
silent execute '!mkdir -p ~/.vim/tmp && for i in backup swap view undo fuf; do mkdir -p ~/.vim/tmp/$i; done'
set backupdir=~/.vim/tmp/backup/
set directory=~/.vim/tmp/swap/
set viewdir=~/.vim/tmp/view/
set undodir=~/.vim/tmp/undo/

" enable backups
set backup

" Tell vim to remember certain things when we exit
"  '100  :  marks will be remembered for up to 100 previously edited files
"  "1000 :  will save up to 1000 lines for each register
"  :100  :  up to 100 lines of command-line history will be remembered
"  %     :  saves and restores the buffer list
"  n...  :  where to save the viminfo files
set viminfo='100,\"1000,:100,n~/.vim/tmp/viminfo

function! MyFoldText() " {{{
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" allow _ to separate words
" set iskeyword-=_

" }}}

" GUI specific ------------------------------------------------------------ {{{

"remove toolbar 
if has("gui_running")
  set guioptions-=T
endif

if has("gui_running")
  set cursorline
endif

if has("gui_gvim")
  set guifont=Inconsolata\ 13
endif

if has("gui_macvim")
  set guifont=Inconsolata:h16
  " use system clipboard
  " set clipboard=unnamed
  " set relativenumber
  " autocmd BufEnter * set relativenumber
  set undofile
  set macmeta
endif

" }}}

" Events ------------------------------------------------------------------ {{{

" save on losing focus
autocmd BufLeave,FocusLost * silent! wall

" restores the cursor position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" auto resize vertical split which has the focus
" function! AutoResize()
"   let w = &columns*55/100
"   exec 'vertical resize '.w
" endfunction
" autocmd WinEnter * call AutoResize()

" Leave insert mode after 15 seconds of no input: 
" au CursorHoldI * stopinsert 
" au InsertEnter * let updaterestore=&updatetime | set updatetime=15000 
" au InsertLeave * let &updatetime=updaterestore

" Don't screw up folds when inserting text that might affect them, until leaving insert mode. 
" Foldmethod is local to the window.
" This also avoids folds to slow down vim while in edit mode
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" }}}

" Sessions ---------------------------------------------------------------- {{{

" function! MakeSession()
"   let b:sessiondir = $HOME . "/.vim/tmp"
"   if (filewritable(b:sessiondir) != 2)
"     exe 'silent !mkdir -p ' b:sessiondir
"     redraw!
"   endif
"   let b:filename = b:sessiondir . "/session"
"   exe "mksession! " . b:filename
" endfunction

" function! LoadSession()
"   let b:sessiondir = $HOME . "/.vim/tmp"
"   let b:sessionfile = b:sessiondir . "/session"
"   if (filereadable(b:sessionfile))
"     exe 'source ' b:sessionfile
"   else
"     echo "No session loaded."
"   endif
" endfunction

" au VimEnter * :call LoadSession()
" au VimLeave * :call MakeSession()

" ,s reloads last session
" nnoremap <leader>s :call LoadSession()<cr>

" }}}

" Laguages ---------------------------------------------------------------- {{{

" omnicomplete
set ofu=syntaxcomplete#Complete
"inoremap <C-space> <C-x><C-o>

" ruby file types
au BufNewFile,BufRead [vV]agrantfile     set filetype=ruby
au BufNewFile,BufRead Gemfile            set filetype=ruby
au BufNewFile,BufRead Capfile            set filetype=ruby
au BufNewFile,BufRead [rR]akefile,*.rake set filetype=ruby

" ruby autocomplete
if has("ruby")
  autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
endif

if has("python")
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
end

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

exec "set tags=".fnamemodify('.',':p:p')."tags"
exec "set tags+=".fnamemodify('.',':p:p')."../tags"

" use markers for folds in .vimrc and other vim files
autocmd FileType vim setlocal foldmethod=marker

" persist fold status
autocmd BufWinLeave .* mkview
autocmd BufWinEnter .* silent loadview

" disable auto comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" lisp rainbow parens
let g:lisp_rainbow=1

" slimv repl syntax coloring
let g:slimv_repl_syntax = 1

" open repl in a vertical split on the right
let g:slimv_repl_split = 4

" }}}

" Basic mappings ---------------------------------------------------------- {{{

" clear out a search by typing ,<space>
nnoremap <leader><space> :noh<cr>

"make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

" navigate around tabs/buffers
nnoremap <d-9> :bprev<cr>
nnoremap <d-0> :bnext<cr>
" nnoremap <d-¹> :BufSurfBack<cr>
" nnoremap <d-°> :BufSurfForward<cr>
nnoremap <leader>z :bd<cr>
" nnoremap ` :b#<cr>
nnoremap ' :b#<cr>

" copy blocks of text using command-alt-up/down
vmap <M-D-k> yPv`]
vmap <M-D-j> y`]pv`]

" bubble lines with ALT+[jk] (using unimpaired plugin)
"a-j
nmap ê ]e
"a-k
nmap ë [e
"a-j
vmap ê ]egv
"a-k
vmap ë [egv

" indent with ALT+[hl]
"a-h
nnoremap è <<
"a-l
nnoremap ì >>
"a-h
inoremap è <Esc><<`]a
"a-l
inoremap ì <Esc>>>`]a
"a-h
vnoremap è <gv
"a-l
vnoremap ì >gv

" control-j/k/h/l move to split up/down/left/right
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" control-+/- to resize splits
nnoremap <silent>== <C-w>>
nnoremap <silent>-- <C-w><

" ,v reselect the text that was just pasted
" nnoremap <leader>v V`]

" remap ESC
inoremap jj <esc>
" inoremap ; <esc>
" inoremap <esc> <nop>

" make better use of H and L
map H ^
map L $

" make better use of ;
nnoremap ; :

" ,z to zoom in/out splits
" nnoremap <leader>z <C-w>o

" ,r reformats file
nnoremap <leader>r gg=G``<cr>

" disable the arrow keys while you’re in normal mode to help you learn to use hjkl
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" get rid of that stupid goddamned help key that you will invaribly hit constantly while aiming for escape
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" use :w!! to write to a file using sudo if you forgot to sudo vim file
cmap w!! %!sudo tee > /dev/null %

" wrap words/selections
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader># viw<esc>a}<esc>hbi#{<esc>lel
nnoremap <leader>( viw<esc>a)<esc>hbi(<esc>lel
vnoremap <leader>" <esc>`<i"<esc>lv`>l<esc>a"<esc>
vnoremap <leader>' <esc>`<i'<esc>lv`>l<esc>a'<esc>
vnoremap <leader>( <esc>`<i(<esc>lv`>l<esc>a)<esc>
vnoremap <leader># <esc>`<i#{<esc>llv`>ll<esc>a}<esc>

" }}}

" Commands ---------------------------------------------------------------- {{{

":V edits .vimrc
:command! V exe "e ~/.vim/vimrc"

":VV reloads .vimrc
:command! VV exe "w | mkview | source ~/.vimrc | filetype detect | echo 'vimrc reloaded'"

" :C opens !/.vim/cheasheet.txt
:command! C exe "e ~/.vim/cheasheet.txt"

" :H shows hidden characters
:command! H exe ":set list!"

" :F opens lusty
:command! L exe ":LustyFilesystemExplorer"

" :T opens fuzzy finder
:command! F exe ":FufFile"

" :Q closes all buffers
:command! Q exe ":bufdo bdelete"

" :T converts all buffers into tabs
:command! T exe ":tab sball"

" :Z strips all trailing whitespace in the current file
:command! Z exe ":%s/\s\+$// | :let @/=''"

" :R to execute ruby script
:command! R exe ":w | :! ruby %"

" :P to execute python script
:command! P exe ":w | :! python %"

" ,j to execute java class
:command! J exe ":w | :! javac -cp .:lib/* % && java %:s/.java//"

" ,J to execute java test
:command! JT exe ":w| :! javac -cp .:lib/* % %:s/Test.java/.java/ && java -cp .:lib/* org.junit.runner.JUnitCore %:s/.java//"

" :CC to execute c program
:command! CC exe ":w | :! gcc % -o %:s/.c// && ./%:s/.c//"

" :CP to execute c++ program
:command! CP exe ":w | :! g++ % -o %:s/.cpp// && ./%:s/.cpp//"

" :S to turn on/off spell checker
:command! S exe ":set spell!"

" :U turns on/off gundo
:command! U exe ":GundoToggle"

" }}}

" Plugin options ---------------------------------------------------------- {{{

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

" neocomplcache
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
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" }}}

" Plugin mappings --------------------------------------------------------- {{{

" peepopen
map <leader><space> :PeepOpen<cr><cr>

" ,t opens ctrlp
let g:ctrlp_map = '<leader>t'
nnoremap <leader>l :CtrlPBuffer<cr>

" ,l opens lusty buffer explorer
" nnoremap <leader>l :LustyBufferExplorer<cr>

" ,a opens ACK
nnoremap <leader>a :Ack<space>

" ,g opens Grep
nnoremap <leader>g :Grep<space>

" ,y toggles nerdtree
nnoremap <leader>y :NERDTreeToggle<cr>

" \\ toggles comments
nnoremap \\ :call NERDComment("n", "toggle")<CR>
vnoremap \\ :call NERDComment("n", "toggle")<CR>gv

" ,h shows yankring history
" nnoremap <leader>v :YRShow<cr>

" nerdtree
" nnoremap <d-d> :NERDTreeToggle<cr>

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

" }}}

