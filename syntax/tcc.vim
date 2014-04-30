" Vim syntax file
" Language: TCC FSP log

if exists("b:current_syntax")
  finish
endif

" Trace
syn match entering 'Entering scope:'
syn match exiting 'Exiting scope:'

highlight ent ctermfg=LightGreen
highlight exi ctermfg=LightRed
hi def link entering ent
hi def link exiting exi 

" File
highlight fi ctermfg=yellow
syn match file '[a-zA-Z0-9_-]*\.[hc]pp'
hi def link file fi

" Subsystem
highlight i ctermfg=magenta
highlight r ctermfg=blue
syn match cbi '4[0-9]\{2\}' contained
syn match cbr '3[0-9]\{2\}' contained
syn match file2comma ',[0-9]\{3\},' contains=cbi,cbr
hi def link cbr r
hi def link cbi i
