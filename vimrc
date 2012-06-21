
" get rid of all the crap that vim does to be vi compatible
set nocompatible

filetype off  

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" peepopen file chooser application
" <leader><space> opens peepeopen (custom.vim)
Bundle 'shemerey/vim-peepopen'

" fast and easy find and replace across multiple files
" <leader>vv  grep for the word under the cursor
" <leader>g  open grep dialog
Bundle 'vim-scripts/EasyGrep'

" provides an overview of the structure of source code files (uses ctags)
" :TlistToggle toggles taglist view
Bundle 'vim-scripts/taglist.vim'

" shows a tabs-like list of buffers in the bottom of the window
Bundle 'vim-scripts/buftabs'

" updates tags file automatically
" searches for tags file in the current and parent directories
Bundle 'vim-scripts/AutoTag'

" colorsheme scroller, chooser, and browser
" :SCROLL scrolls across colorschemes
Bundle 'vim-scripts/ScrollColors'

" zoom in/out of windows
" <c-w>o 
Bundle 'vim-scripts/ZoomWin'

" a tree explorer plugin for navigating the filesystem
" <leader>y toggles nerdtree (custom.vim)
" o opens dir
" O opens dir recursively
" x closes node's parent
" X closes dir recursively
" s opens file in vsplit
" C changes root to current dir
" u moves root up one dir
" r refresh current dir
" R refresh root
" m show menu (for add/remove/move operations)
Bundle 'scrooloose/nerdtree'

" git wrapper so awesome, it should be illegal
" :Gstatus shows git status
"   - c-n and c-p move around files
"   - '-' (dash) adds/remove files from index (also works in visual mode)
"   - Git add . adds all files to index
"   - p allows for hunks of changes to be added individually to the index
"   - <enter> opens the file; :Gdiff allows for reviewing changes 
"   - C commits changes
" :Gdiff shows git diff
"   - Gwrite in the working copy vsplit stages all changes
"   - Gread in the working copy vsplit reverts file to the contents of the last commit 
"   - u in the staged vsplit undoes staging of changes
"   - :diffget and :diffobtain in the index vsplit stages a given hunk of changes (requires :w to save changes) (confirm with git diff --cached)
" :Gdiff on files that require merge
"   - left split (//2) is the target branch (the branch that was active when git merge was run, aka HEAD)
"   - middle split is the working copy (with conflict markers)
"   - right split (//3) s the merge branch 
"   - :dp (or :diffput) while in the left or right splits puts the changes to the working copy
"   - :dp | :diffup will put the change and update the vimdiff
"   - ]c jumps to the next conflict
"   - [c to the previous conflict
"   - :Gwrite in the working copy adds changes to the index
" :Gedit <branch>:<path> opens file from a specific branch
" :Gedit <shar> opens buffer with an overview of the corresponding commit (same as git show)
"   - enter on any commit object opens buffer with commit overview
"   - enter on any file opens diff view 
"   - enter on the tree shar shows tree for that shar id
"     - C returns to the commit object
"   - .. moves to the parent object in the tree (custom.rb)
" :Glog loads all ancestral commit objects into the quickfix list
" :Glog -- % loadw all ancestral commit objects that touched the current file into the quickfix list
"   - unimpaired defines:
"      [q	:cprev	jump to previous (newer in time)
"      ]q	:cnext	jump to next (older in time)
"      [Q	:cfirst	jump to first
"      ]Q	:clast	jump to last
" :Ggrep 'find me' finds all occurences of 'find me' in the working copy files
" :Glog --grep=findme -- search for 'findme' in all ancestral commit messages
" :Glog --grep=findme -- % search for 'findme' in all ancestral commit messages that touch the currently active file
" :Glog -Sfindme -- search for 'findme' in the diff for each ancestral commit
" :Glog -Sfindme -- % search for 'findme' in the diff for each ancestral commit that touches the currently active file
" :Gread reverts file to the contents from last commit
" :Gremove removes from git and wipes out the buffer (:bwipeout)
" :Gmove <new location> moves the file and reopens the buffer with the updated file (/ refers to the root of the git repo)
" :Gcommit commits staged changes
" :Gblame shows vsplit with commit annotations 
Bundle 'tpope/vim-fugitive'

" markdown support
Bundle 'tpope/vim-markdown'

" . repeats commands from some plugins (surround, unimpaired, etc)
Bundle 'tpope/vim-repeat'

" handles complementary pairs of mappings
" [x and ]x encode and decode XML (and HTML)
" [u and ]u encode and decode URLs
" [y and ]y do C String style escaping
" a-j and a-k move lines (or blocks of lines) up and down (defaults.vim)
Bundle 'tpope/vim-unimpaired'

" mappings to easily delete, change and add such surroundings in pairs
" S<surround> in visual mode surrounds selection with <surround>
" eg. S" surrounds selection with "
"     S<p class="important"> surrounds selection with <p class="important"> and </p>
" cs"' changes surrounding from " to '
" ds" removes " surrounding
" yse" surrounds word with "
Bundle 'tpope/vim-surround'

" syntax checking plugin that runs files through external syntax checkers and displays any resulting errors
" not activated unless file is saved with :w (autofocus saving doesn't work with it)
Bundle 'scrooloose/syntastic'

" easy commenting of code for many filetypes
" <leader>c<space>
" \\ (custom.vim)
Bundle 'scrooloose/nerdcommenter'

" performs keyword completion by making a cache of keywords in a buffer
" tab cycles across option 
" enter selects option (custom.vim)
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neocomplcache-snippets-complete'

" fuzzy file, buffer, mru, tag, etc. finder with regexp support
" <leater>t opens file mode (custom.vim)
" <leater>l opens buffer mode (custom.vim)
Bundle 'kien/ctrlp.vim'

" textile support
Bundle 'timcharper/textile.vim'

" makes it easy to align regions of text that match a pattern
" :Tab /| aligns on | 
" :Tab /=\zs aligns on = and keep = close to the left token
Bundle 'godlygeek/tabular'

" extended % matching for HTML, LaTeX, and many other languages 
Bundle 'tsaleh/vim-matchit'

" the ultimate vim statusline utility
Bundle 'Lokaltog/vim-powerline'

" enables surfing through buffers based on viewing history per window
" changes the behaviors of :bprev and :bnext
" D-( switches to last viewed buffer (custom.vim)
" D-) switches to next viewed buffer (custom.vim)
Bundle 'ton/vim-bufsurf'

" front for the Perl module App::Ack
" ,a (custom.vim)
Bundle 'mileszs/ack.vim'

" color schemes
Bundle 'Zenburn'
Bundle 'molokai'

if has("python")
  " visualizing your undo tree to make it usable
  " :U (custom.vim)
  Bundle 'sjl/gundo.vim'

  " a 'bundles' menu for vim (like textmate) 
  Bundle 'mbadran/headlights'

  " superior lisp interaction mode for vim
  Bundle 'vim-scripts/slimv.vim'
endif

filetype plugin indent on

" load defaults
source ~/.vim/defaults.vim

" load customizations
source ~/.vim/custom.vim

