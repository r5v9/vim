hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear
hi Normal               guifg=#404040      guibg=#fffff0

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "rufiao"

" vim: sw=2
