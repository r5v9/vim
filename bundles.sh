#!/bin/sh

GIT_BUNDLES="
git://github.com/wincent/Command-T.git
git://github.com/vim-scripts/FuzzyFinder.git
git://github.com/vim-scripts/L9.git
git://github.com/mileszs/ack.vim.git
git://github.com/tpope/vim-fugitive.git
git://github.com/sjl/gundo.vim.git
git://github.com/sjbach/lusty.git
git://github.com/tpope/vim-markdown.git
git://github.com/scrooloose/nerdcommenter.git
git://github.com/scrooloose/nerdtree.git
git://github.com/tpope/vim-repeat.git
git://github.com/vim-scripts/scratch.vim.git
git://github.com/vim-scripts/slimv.vim.git
git://github.com/ervandew/supertab.git
git://github.com/tpope/vim-surround.git
git://github.com/scrooloose/syntastic.git
git://github.com/timcharper/textile.vim.git
git://github.com/tpope/vim-unimpaired.git
git://github.com/vim-scripts/ZoomWin.git
git://github.com/godlygeek/tabular.git
git://github.com/tsaleh/vim-tcomment.git
git://github.com/tsaleh/vim-matchit.git
git://github.com/tpope/vim-surround.git
"

# clone/update bundles from git
mkdir -p bundle
for i in $GIT_BUNDLES; do
  name=`echo $i | perl -pe 's/(.+)\/(.+).git/$2/g'`
  if [ -d "bundle/$name" ]; then 
    (cd "bundle/$name" && git pull origin master)
  else
    (cd bundle && git clone $i)
  fi
done

# command-t ruby build
(cd bundle/Command-T && rake make)

# python support in syntastic
# sudo pip install pyflakes

