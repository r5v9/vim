
" Preamble ---------------------------------------------------------------- {{{

" load pathogen (all plugins in the bundles folder)
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

" }}}

" Basic options ----------------------------------------------------------- {{{

"set font and color scheme
colorscheme zenburn

" gets rid of all the crap that Vim does to be vi compatible
set nocompatible

" prevents some security exploits having to do with modelines in files
" see http://lists.alioth.debian.org/pipermail/pkg-vim-maintainers/2007-June/004020.html
set modelines=0

" tab setttings. expand tabs to spaces, use width 4
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
set scrolloff=3
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
set number
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
set gcr=a:blinkwait0,a:block-cursor

" handle long lines
"set wrap
"set textwidth=120
"set formatoptions=qrn1
"set colorcolumn=120

" Set region to British English
set spelllang=en_gb

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
set viminfo='100,\"1000,:100,%,n~/.vim/tmp/viminfo

" improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

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
au CursorHoldI * stopinsert 
au InsertEnter * let updaterestore=&updatetime | set updatetime=15000 
au InsertLeave * let &updatetime=updaterestore

" }}}

" Sessions ---------------------------------------------------------------- {{{

function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/tmp"
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . "/session"
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/tmp"
  let b:sessionfile = b:sessiondir . "/session"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" au VimEnter * :call LoadSession()
" au VimLeave * :call MakeSession()

" ,s reloads last session
" nnoremap <leader>s :call LoadSession()<CR>

" }}}

" Laguages ---------------------------------------------------------------- {{{

" ruby file types
au BufNewFile,BufRead [vV]agrantfile     set filetype=ruby
au BufNewFile,BufRead Gemfile            set filetype=ruby
au BufNewFile,BufRead Capfile            set filetype=ruby
au BufNewFile,BufRead [rR]akefile,*.rake set filetype=ruby

" ruby autocomplete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

" use markers for folds in .vimrc and other vim files
autocmd FileType vim setlocal foldmethod=marker

" persist fold status
autocmd BufWinLeave .* mkview
autocmd BufWinEnter .* silent loadview

" }}}

" Basic mappings ---------------------------------------------------------- {{{

" clear out a search by typing ,,<space>
nnoremap <leader><leader><space> :noh<cr>

"make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

" navigate around tabs/buffers
map <d-left> :BufSurfBack<CR>
map <d-right> :BufSurfForward<CR>
nnoremap <leader>z :bd<CR>
nnoremap <leader>l :LustyBufferExplorer<CR>

" copy blocks of text using shift-up/down
" vmap <c-s-down> y`]o<esc>pv`]
" vmap <c-s-up> yO<esc>P`[v`]

" bubble lines with ALT+[jk] (using unimpaired plugin)
"a-j
nmap ∆ ]e
"a-k
nmap ˚ [e
"a-j
vmap ∆ ]egv
"a-k
vmap ˚ [egv

" indent with ALT+[hl]
"a-h
nnoremap ˙ <<
"a-l
nnoremap ¬ >>
"a-h
inoremap ˙ <Esc><<`]a
"a-l
inoremap ¬ <Esc>>>`]a
"a-h
vnoremap ˙ <gv
"a-l
vnoremap ¬ >gv

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

" remap jk and kj as ESC
inoremap jk <esc>
inoremap kj <esc>
inoremap <esc> <nop>

" make better use of H and L
map H ^
map L $

" make better use of ;
nnoremap ; :

" ,w/W for horizontal/vertical splits
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>W <C-w>s<C-w>j

" ,z to zoom in/out splits
" nnoremap <leader>z <C-w>o

" ,r reformats file
nnoremap <leader>r gg=G``<CR>

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
:command! V exe "e ~/.vimrc"

":VV reloads .vimrc
:command! VV exe "w | source ~/.vimrc | filetype detect | echo 'vimrc reloaded'"

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

" Ctrl-P
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_cache_dir = $HOME.'/.vim/tmp/ctrlp'

" }}}

" Plugin mappings --------------------------------------------------------- {{{

" nerdtree
nnoremap <d-d> :NERDTreeToggle<cr>

" peepopen
" map ,, :PeepOpen<CR><CR>
map <leader><space> :PeepOpen<CR><CR>

" use ,t to open ctrlp
let g:ctrlp_map = '<leader>t'
nnoremap <leader>b :CtrlPBuffer<cr>

" ,a opens ACK
nnoremap <leader>a :Ack<space>

" ,y toggles nerdtree
" nnoremap <leader>y :NERDTreeToggle<CR>

" ,h shows yankring history
" nnoremap <leader>v :YRShow<CR>

" }}}

