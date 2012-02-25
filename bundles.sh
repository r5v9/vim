#!/bin/sh

GIT_BUNDLES_RETIRED="
https://github.com/mileszs/ack.vim.git
https://github.com/wincent/Command-T.git
https://github.com/ervandew/supertab.git
https://github.com/vim-scripts/camelcasemotion.git
https://github.com/vim-scripts/tComment.git
https://github.com/Raimondi/delimitMate.git
https://github.com/vim-scripts/FuzzyFinder.git
https://github.com/sjbach/lusty.git
https://github.com/vim-scripts/ZoomWin.git
"

GIT_BUNDLES="
https://github.com/kien/ctrlp.vim.git
https://github.com/scrooloose/nerdtree.git
https://github.com/vim-scripts/L9.git
https://github.com/tpope/vim-fugitive.git
https://github.com/sjl/gundo.vim.git
https://github.com/tpope/vim-markdown.git
https://github.com/tpope/vim-repeat.git
https://github.com/tpope/vim-commentary.git
https://github.com/scrooloose/syntastic.git
https://github.com/timcharper/textile.vim.git
https://github.com/tpope/vim-unimpaired.git
https://github.com/godlygeek/tabular.git
https://github.com/tsaleh/vim-matchit.git
https://github.com/tpope/vim-surround.git
https://github.com/vim-scripts/ScrollColors.git
https://github.com/Lokaltog/vim-powerline.git
https://github.com/vim-scripts/EasyGrep.git
https://github.com/mbadran/headlights.git
https://github.com/vim-scripts/taglist.vim.git
https://github.com/Lokaltog/vim-easymotion.git
https://github.com/vim-scripts/buftabs.git
https://github.com/ton/vim-bufsurf.git
https://github.com/vim-scripts/snipMate.git
"

# pathogen
mkdir -p autoload
if [ -d "autoload/vim-pathogen" ]; then
  (cd autoload/vim-pathogen && git pull origin master)
else
  (cd autoload && git clone https://github.com/tpope/vim-pathogen.git)
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

