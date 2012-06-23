
" basic settings ---------------------------------------------------------------

" gets rid of all the crap that Vim does to be vi compatible
set nocompatible

" prevents some security exploits having to do with modelines in files
" see http://lists.alioth.debian.org/pipermail/pkg-vim-maintainers/2007-June/004020.html
set modelines=0

" tab setttings. expand tabs to spaces, use width 2
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" autoreload files if changed externally
set autoread

" utf-8 by default
set encoding=utf-8

" at least 5 lines above or below the cursor
set scrolloff=5

" autoident
set autoindent

" show (partial) command in the last line of the screen
set showcmd

" buffers becomes hidden when abandoned
set hidden

" enhanced mode for command-line completion
set wildmenu
set wildmode=list:longest

" use visual bell instead of beeping
set visualbell

" fast terminal connection (more characters will be sent to the screen for redrawing)
set ttyfast

" show the line and column number of the cursor position
set ruler

" backspacing over autoindent, line breaks (join lines) and start of insert
set backspace=indent,eol,start

" last window always have status line
set laststatus=2

" disable line numbers
set nonumber

" ignore binary files
set wildignore+=*.o,*.obj,.git,*.class,*.jar,*.pyc

" if you search for an all-lowercase string your search will be case-insensitive, 
" but if one or more characters is uppercase the search will be case-sensitive
set ignorecase
set smartcase

" applies substitutions globally on lines (s/../../g by default)
set gdefault

" highlight search results as you type
set incsearch
set showmatch
set hlsearch

" use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" folders
silent execute '!mkdir -p ~/.vim/tmp && for i in backup swap view undo; do mkdir -p ~/.vim/tmp/$i; done'
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

" disable auto comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" disable folds (they slow things down)
set nofoldenable

" basic mappings --------------------------------------------------------------- 

" use , as the leader key
let mapleader = ","

" clear out a search by typing ,/
nnoremap <leader>/ :noh<cr>

"make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

" navigate around tabs/buffers
nnoremap <d-9> :bprev<cr>
nnoremap <d-0> :bnext<cr>

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

" control-j/k/h/l move to the split up/down/left/right
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" jj as ESC in insert mode
inoremap jj <esc>

" make better use of ;
nnoremap ; :

" disable the arrow keys while you’re in normal mode to help you learn to use hjkl
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" D-h/j/k/l/w/b move around in insert mode
" D-x/c/d/u remove/change/delete/undo in insert mode
" ~/.gvimrc unmaps some command shortcuts in macvim
inoremap <D-h> <C-o>h
inoremap <D-j> <C-o>j
inoremap <D-k> <C-o>k
inoremap <D-l> <C-o>l
inoremap <D-b> <C-o>b
inoremap <D-w> <C-o>w
inoremap <D-x> <C-o>x
inoremap <D-c> <C-o>c
inoremap <D-d> <C-o>d
inoremap <D-u> <C-o>u

" D-r reformats file
nnoremap <D-r> gg=G``<cr><up>

" j and k move around displayed lines (for wrapped text)
nnoremap j gj
nnoremap k gk

" get rid of that stupid goddamned help key that you will invaribly hit constantly while aiming for escape
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" use :w!! to write to a file using sudo if you forgot to sudo vim file
cmap w!! %!sudo tee > /dev/null %

" events -----------------------------------------------------------------------

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

" file types -------------------------------------------------------------------

" ruby file types
au BufNewFile,BufRead [vV]agrantfile     set filetype=ruby
au BufNewFile,BufRead Gemfile            set filetype=ruby
au BufNewFile,BufRead Capfile            set filetype=ruby
au BufNewFile,BufRead [rR]akefile,*.rake set filetype=ruby

" autocomplete -----------------------------------------------------------------

set ofu=syntaxcomplete#Complete

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

" use enter to select option in the autocomplete menu
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" ctags ------------------------------------------------------------------------

exec "set tags=".fnamemodify('.',':p:p')."tags"
exec "set tags+=".fnamemodify('.',':p:p')."../tags"
