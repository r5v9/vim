#!/bin/sh

GIT_COLORS="
git://github.com/vim-scripts/Color-Sampler-Pack.git
git://github.com/telamon/vim-color-github.git
git://github.com/larssmit/vim-getafe.git
git://github.com/wgibbs/vim-irblack.git
git://github.com/TechnoGate/janus-colors.git
git://github.com/vim-scripts/molokai.git
git://github.com/vim-scripts/pyte.git
git://github.com/altercation/vim-colors-solarized.git
git://github.com/tpope/vim-vividchalk.git
git://github.com/sjl/badwolf.git
"

FAVORITES_DARK="anotherdark blacksea breeze camo candycode clarity dante darkZ darkblue2 desertEx dusk fnaqevan freya fruity inkpot jellybeans kellys lucius molokai molokai-rufiao moria mustang navajo-light neon no_quarter railscasts2 badwolf twilight vividchalk wombat zenburn"
FAVORITES_LIGHT="autumn2 bclear buttercream dawn eclipse fog fruit github habilight ironman nuvola pyte rufiao tolerable"
FAVORITES="$FAVORITES_DARK"
#FAVORITES="$FAVORITES_LIGHT"
#FAVORITES="all"

mkdir -p colors/repos
rm -rf colors/all && mkdir colors/all
for i in $GIT_COLORS; do
  name=`echo $i | perl -pe 's/(.+)\/(.+).git/$2/g'`
  if [ -d "colors/repos/$name" ]; then 
    (cd "colors/repos/$name" && git pull origin master)
  else
    (cd colors/repos && git clone $i)
  fi
  (cd colors/all && ln -sf ../repos/$name/colors/* .)
done

(cd colors/all && ln -s ../authored/* .)

rm -f colors/*.vim
if [ "$FAVORITES" == "all" ]; then
  (cd colors && ln -s all/* .)
else
  for i in $FAVORITES; do
    (cd colors && ln -s all/$i.vim .)
  done
fi
