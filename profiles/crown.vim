" Test: Somewhat nicer diff colors
hi DiffChange cterm=none ctermfg=none ctermbg=none
hi DiffText   cterm=none ctermfg=Red ctermbg=black

let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader><f3> :VimspectorReset<CR>
"    F5	  VimspectorContinue
"    F3	  VimspectorStop
"    F4	  VimspectorRestart
"    F6	  VimspectorPause
"    F9	  VimspectorToggleBreakpoint
" <l>F9	  VimspectorToggleConditionalBreakpoint
"    F8	  VimspectorAddFunctionBreakpoint
" <l>F8	  VimspectorRunToCursor
"    F10	VimspectorStepOver
"    F11	VimspectorStepInto
"    F12	VimspectorStepOut

set textwidth=120
