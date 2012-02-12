"set font and color scheme
"colorscheme rufiao
"colorscheme codeburn
"colorscheme fokus
"colorscheme wombat
colorscheme darkblue2

"remove toolbar in macvim
if has("gui_running")
  set guioptions-=T
endif

" load pathogen (all plugins in the bundles folder)
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

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
set showmode
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

" options for macvim and gvim
if has("gui_running")
  set cursorline
endif

if has("gui_gvim")
  set guifont=Inconsolata\ 13
endif

" macvim only options
if has("gui_macvim")
  set guifont=Inconsolata:h18
  " use system clipboard
  " set clipboard=unnamed
  set relativenumber
  set undofile
endif

" ignore binary files
set wildignore+=*.o,*.obj,.git,*.class,*.jar,*.pyc

" use , as the leader key
let mapleader = ","

" configure slimv
let g:slimv_lisp = '"plt-r5rs"'
let g:slimv_keybindings = 2

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

" clear out a search by typing ,<space>
nnoremap <leader><space> :noh<cr>

" tab key match bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" disable blinking cursor
" set gcr=a:blinkwait0,a:block-cursor

" handle long lines
"set wrap
"set textwidth=120
"set formatoptions=qrn1
"set colorcolumn=120

" get rid of that stupid goddamned help key that you will invaribly hit constantly while aiming for escape
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" make ; do the same thing as :
" nnoremap ; :

" save on losing focus
autocmd BufLeave,FocusLost * silent! wall

"make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

" navigate around tabs using alt-left/right
" map <s-left> :bprev<CR>
" map <s-right> :bnext<CR>
map <s-left> :BufSurfBack<CR>
map <s-right> :BufSurfForward<CR>
nnoremap <leader>z :bd<CR>
nnoremap <leader>l :LustyBufferExplorer<CR>
map ,, :LustyBufferExplorer<CR><CR>

" copy blocks of text using shift-up/down
" vmap <c-s-down> y`]o<esc>pv`]
" vmap <c-s-up> yO<esc>P`[v`]

" bubble lines (using unimpaired plugin)
nmap <s-up> [e
nmap <s-down> ]e
vmap <s-up> [egv
vmap <s-down> ]egv

" control-j/k/h/l move to split up/down/left/right
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

":V edits .vimrc
":VV reloads .vimrc
:command! V exe "e ~/.vimrc"
:command! VV exe "w | source ~/.vimrc | filetype detect | echo 'vimrc reloaded'"

" :C opens !/.vim/cheasheet.txt
:command! C exe "e ~/.vim/cheasheet.txt"

" :H shows hidden characters
:command! H exe ":set list!"

" :F opens lusty
:command! L exe ":LustyFilesystemExplorer"

" :T opens fuzzy finder
:command! T exe ":FufFile"

" :Q closes all buffers
:command! Q exe ":bufdo bdelete"

" control-+/- to resize splits
" map <silent><Leader>=

" remap jj as ESC
inoremap jj <ESC>

" :Z  strips all trailing whitespace in the current file
:command! T exe ":%s/\s\+$// | :let @/=''"

" ,a opens ACK
nnoremap <leader>a :Ack<space>

" ,v reselect the text that was just pasted
" nnoremap <leader>v V`]

" ,y toggles nerdtree
" nnoremap <leader>y :NERDTreeToggle<CR>

" ,h shows yankring history
" nnoremap <leader>v :YRShow<CR>

" ,w/W for horizontal/vertical splits
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>W <C-w>s<C-w>j

" ,z to zoom in/out splits
" nnoremap <leader>z <C-w>o

" :R to execute ruby script
:command! R exe ":w | :! ruby %"

" :P to execute python script
:command! P exe ":w | :! python %"

" ,r reformats file
nnoremap <leader>r gg=G``<CR>

" ,j to execute java class
" nnoremap <leader>j :w<CR>:! javac -cp .:lib/* % && java %:s/.java//<CR>

" ,J to execute java test
" nnoremap <leader>J :w<CR>:! javac -cp .:lib/* % %:s/Test.java/.java/ && java -cp .:lib/* org.junit.runner.JUnitCore %:s/.java//<CR>

" :CC to execute c program
:command! CC exe ":w | :! gcc % -o %:s/.c// && ./%:s/.c//"

" :CP to execute c++ program
:command! CP exe ":w | :! g++ % -o %:s/.cpp// && ./%:s/.cpp//"

" :S to turn on/off spell checker
:command! S exe ":set spell!"

" :U turns on/off gundo
:command! U exe ":GundoToggle"

" Set region to British English
set spelllang=en_gb

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

" use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" configure syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

silent execute '!mkdir -p ~/.vim/tmp && for i in backup dir view undo fuf; do mkdir -p ~/.vim/tmp/$i; done'
set backupdir=~/.vim/tmp/backup/
set directory=~/.vim/tmp/dir/
set viewdir=~/.vim/tmp/view/
set undodir=~/.vim/tmp/undo/

" fuzzyfinder datadir
let g:fuf_dataDir="~/.vim/tmp/fuf"

" Tell vim to remember certain things when we exit
"  '100  :  marks will be remembered for up to 100 previously edited files
"  "1000 :  will save up to 1000 lines for each register
"  :100  :  up to 100 lines of command-line history will be remembered
"  %     :  saves and restores the buffer list
"  n...  :  where to save the viminfo files
set viminfo='100,\"1000,:100,%,n~/.vim/tmp/.viminfo

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

" auto save/load session

function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/tmp"
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . "/session.vim"
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/tmp"
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" au VimEnter * :call LoadSession()
au VimLeave * :call MakeSession()

" ,s reloads last session
nnoremap <leader>s :call LoadSession()<CR>

" ruby file types
au BufNewFile,BufRead [vV]agrantfile     set filetype=ruby
au BufNewFile,BufRead Gemfile            set filetype=ruby
au BufNewFile,BufRead Capfile            set filetype=ruby
au BufNewFile,BufRead [rR]akefile,*.rake set filetype=ruby

" function! AutoResize()
"   let w = &columns*55/100
"   exec 'vertical resize '.w
" endfunction
"  
" autocmd WinEnter * call AutoResize()

" use :w!! to write to a file using sudo if you forgot to sudo vim file
cmap w!! %!sudo tee > /dev/null %

set winaltkeys=no
map <A-right> <Plug>CamelCaseMotion_w
map <A-left> <Plug>CamelCaseMotion_b
"map <A-e> <Plug>CamelCaseMotion_e

" let g:camelchar = "A-Z0-9.,;:{([`'\""
" nnoremap <A-Left> :call search('\<\<Bar>\u', 'bW')<CR>
" nnoremap <A-Right> :call search('\<\<Bar>\u', 'W')<CR>

