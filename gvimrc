
" macmenu commands only execute in .gvimrc

if has("gui_running")
  " remove toolbar
  set guioptions-=T
  " highlight cursor line
  set cursorline
endif

if has("gui_macvim")
  set guifont=Monaco:h13
  " save undo's after file closes
  set undofile
  " use option (alt) as meta key
  set macmeta

  " free command-w
  macmenu File.Close key=<nop>

  " free command-l
  macmenu Tools.List\ Errors key=<nop>

  " free command-b
  macmenu Tools.Make key=<nop>

  " free command-h (hide window), remap to control-command-h
  let foo=system('defaults write org.vim.MacVim NSUserKeyEquivalents -dict-add "Hide MacVim" "@\$H"')
endif
