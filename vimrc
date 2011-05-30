"set font and color scheme
colorscheme rufiao

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
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

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
    set guifont=Inconsolata:h16
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
au FocusLost * :wa

"make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

" navigate around tabs using alt-left/right
map <s-left> :bprev<CR>
map <s-right> :bnext<CR>
map <C-z> :bd<CR>

" copy blocks of text using shift-up/down
vmap <c-s-down> y`]o<esc>pv`]
vmap <c-s-up> yO<esc>P`[v`]

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

" control-+/- to resize splits
" map <silent><Leader>=

" remap jj as ESC
inoremap jj <ESC>

" ,z  strips all trailing whitespace in the current file
nnoremap <leader>z :%s/\s\+$//<cr>:let @/=''<CR>

" ,a opens ACK
nnoremap <leader>a :Ack<space>

" ,v reselect the text that was just pasted
nnoremap <leader>v V`]

" ,y toggles nerdtree
nnoremap <leader>y :NERDTreeToggle<CR>

" ,h shows yankring history
" nnoremap <leader>v :YRShow<CR>

" ,w/W for horizontal/vertical splits
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>W <C-w>s<C-w>j

" ,z to zoom in/out splits
" nnoremap <leader>z <C-w>o

" ,p to execute python script
nnoremap <leader>p :w<CR>:! python %<CR>

" ,j to execute java class
nnoremap <leader>j :w<CR>:! javac -cp .:lib/* % && java %:s/.java//<CR>

" ,J to execute java test
nnoremap <leader>J :w<CR>:! javac -cp .:lib/* % %:s/Test.java/.java/ && java -cp .:lib/* org.junit.runner.JUnitCore %:s/.java//<CR>

" ,c to execute c program
nnoremap <leader>c :w<CR>:! gcc % -o %:s/.c// && ./%:s/.c//<CR>

" ,C to execute c++ program
nnoremap <leader>C :w<CR>:! g++ % -o %:s/.cpp// && ./%:s/.cpp//<CR>

" ,S to turn on/off spell checker
nnoremap <leader>S :set spell!<CR>

" ,u turns on/off gundo
nnoremap <leader>u :GundoToggle<CR>

" Set region to British English
set spelllang=en_gb

",v edits .vimrc
",V reloads .vimrc
map ,v :tabnew ~/.vimrc<CR>
map <silent> ,V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" ,h shows hidden characters
nmap <leader>h :set list!<CR>

" fugitive
nmap <leader>gs :Gstatus<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>ga :Gwrite<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gd :Gdiff<cr>

" use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" configure syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" Tell vim to remember certain things when we exit
"  '100  :  marks will be remembered for up to 100 previously edited files
"  "1000 :  will save up to 1000 lines for each register
"  :100  :  up to 100 lines of command-line history will be remembered
"  %     :  saves and restores the buffer list
"  n...  :  where to save the viminfo files
set viminfo='100,\"1000,:100,%,n~/.viminfo

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
  let b:sessiondir = $HOME . "/.vim/sessions"
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . "/session.vim"
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions"
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


