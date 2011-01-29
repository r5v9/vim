"set font and color scheme
set guifont=Inconsolata:h16
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
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile

" use , as the leader key
let mapleader = ","

" fix broken default regex handling by automatically inserting a \v before any string you search for
nnoremap / /\v
vnoremap / /\v

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

" handle long lines
"set wrap
"set textwidth=120
"set formatoptions=qrn1
"set colorcolumn=120

" disable the arrow keys while you’re in normal mode to help you learn to use hjkl
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
"nnoremap j gj
"nnoremap k gk

" get rid of that stupid goddamned help key that you will invaribly hit constantly while aiming for escape
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" make ; do the same thing as :
nnoremap ; :

" save on losing focus
au FocusLost * :wa

"make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

" navigate around tabs using alt-left/right
map <s-left> :tabp<CR>
map <s-right> :tabn<CR>

" move blocks of text using alt-up/down
nnoremap <a-down> :m+<CR>==
nnoremap <a-up> :m-2<CR>==
inoremap <a-down> <Esc>:m+<CR>==gi
inoremap <a-up> <Esc>:m-2<CR>==gi
vnoremap <a-down> :m'>+<CR>gv=gv
vnoremap <a-up> :m-2<CR>gv=gv

" copy blocks of text using shift-up/down
map <s-down> ygvvo<ESC>pgv
map <s-up> y<ESC>O<ESC>pgv

" remap jj as ESC
inoremap jj <ESC>

" ,s  strips all trailing whitespace in the current file
nnoremap <leader>s :%s/\s\+$//<cr>:let @/=''<CR>

" ,a opens ACK
nnoremap <leader>a :Ack

" ,v reselect the text that was just pasted
nnoremap <leader>v V`]

" ,y toggles nerdtree
nnoremap <leader>y :NERDTreeToggle<CR>

" ,v shows yankring history
nnoremap <leader>v :YRShow<CR>

" ,w/W for horizontal/vertical splits
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>W <C-w>s<C-w>j

" ,z to zoom in/out splits
nnoremap <leader>z <C-w>o

" ,p to open a horizontal split with bash and python
nnoremap <leader>p :ConqueTermVSplit bash<CR><ESC><ESC>:ConqueTermSplit python<CR>

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

" main function that restores the cursor position and its autocmd so that it gets triggered
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

