#!/bin/sh

GIT_BUNDLES_RETIRED="
git://github.com/mileszs/ack.vim.git
git://github.com/wincent/Command-T.git
git://github.com/ervandew/supertab.git
git://github.com/vim-scripts/camelcasemotion.git
git://github.com/vim-scripts/tComment.git
git://github.com/Raimondi/delimitMate.git
git://github.com/vim-scripts/FuzzyFinder.git
git://github.com/sjbach/lusty.git
git://github.com/vim-scripts/ZoomWin.git
"

GIT_BUNDLES="
git://github.com/kien/ctrlp.vim.git
git://github.com/scrooloose/nerdtree.git
git://github.com/vim-scripts/L9.git
git://github.com/tpope/vim-fugitive.git
git://github.com/sjl/gundo.vim.git
git://github.com/tpope/vim-markdown.git
git://github.com/tpope/vim-repeat.git
git://github.com/tpope/vim-commentary.git
git://github.com/scrooloose/syntastic.git
git://github.com/timcharper/textile.vim.git
git://github.com/tpope/vim-unimpaired.git
git://github.com/godlygeek/tabular.git
git://github.com/tsaleh/vim-matchit.git
git://github.com/tpope/vim-surround.git
git://github.com/vim-scripts/ScrollColors.git
git://github.com/Lokaltog/vim-powerline.git
git://github.com/vim-scripts/EasyGrep.git
git://github.com/mbadran/headlights.git
git://github.com/vim-scripts/taglist.vim.git
git://github.com/Lokaltog/vim-easymotion.git
git://github.com/vim-scripts/buftabs.git
git://github.com/ton/vim-bufsurf.git
git://github.com/vim-scripts/snipMate.git
git://github.com/xolox/vim-easytags.git
git://github.com/ecomba/vim-ruby-refactoring.git
"

# pathogen
mkdir -p autoload
if [ -d "autoload/vim-pathogen" ]; then
  (cd autoload/vim-pathogen && git pull origin master)
else
  (cd autoload && git clone git://github.com/tpope/vim-pathogen.git)
fi
(cd autoload && ln -s vim-pathogen/autoload/pathogen.vim .)

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
# (cd bundle/Command-T && rake make)

# python support in syntastic
sudo pip install pyflakes

