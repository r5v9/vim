
" get rid of all the crap that vim does to be vi compatible
set nocompatible

filetype off  

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'shemerey/vim-peepopen'
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/EasyGrep'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/buftabs'
Bundle 'vim-scripts/AutoTag'
Bundle 'vim-scripts/ScrollColors'
Bundle 'vim-scripts/ZoomWin'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Shougo/neocomplcache'
Bundle 'kien/ctrlp.vim'
Bundle 'timcharper/textile.vim'
Bundle 'godlygeek/tabular'
Bundle 'tsaleh/vim-matchit'
Bundle 'Lokaltog/vim-powerline'
Bundle 'ton/vim-bufsurf'
Bundle 'mileszs/ack.vim'
"Bundle 'msanders/snipmate.vim'

" color schemes
Bundle 'Zenburn'
Bundle 'molokai'

if has("python")
  Bundle 'sjl/gundo.vim'
  Bundle 'mbadran/headlights'
  Bundle 'vim-scripts/slimv.vim'
endif

filetype plugin indent on

" load defaults
source ~/.vim/defaults.vim

" load customizations
source ~/.vim/custom.vim

