" Test: Somewhat nicer diff colors
hi DiffChange cterm=none ctermfg=none ctermbg=none
hi DiffText   cterm=none ctermfg=Red ctermbg=black

let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader><f3> :VimspectorReset<CR>
nmap <leader><f4> :call vimspector#LaunchWithSettings({'configuration': 'single-pytest', 'Function': CocAction('getCurrentFunctionSymbol')})<CR>
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

let g:black_use_virtualenv = 1
augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py Black
augroup end
