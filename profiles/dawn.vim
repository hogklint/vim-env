au BufRead,BufNewFile *.hpp set syntax=cpp.doxygen

"""""""
" CtrlP
"""""""
"let g:ctrlp_cmd="CtrlP ~/TCC_ER_CIS_SW"
"let g:ctrlp_cmd="CtrlP ".expand($HOME)."/".expand($CURRENTPROJ)
"let g:ctrlp_root_markers = ['build/.ctrlp']
let g:ctrlp_root_markers = ['.git']
let g:ctrlp_max_height=40
let g:ctrlp_switch_buffer=2
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_dotfiles=0
let g:ctrlp_custom_ignore='SunOS_i86pc$\|\.d$\|\.o$\|\.a$\|\.tcov$\|build$\|^test$\|\.orig$'
let g:ctrlp_lazy_update=0
let g:ctrlp_prompt_mappings = {
 \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
 \ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
 \ 'PrtHistory(-1)':       ['<down>'],
 \ 'PrtHistory(1)':        ['<up>'],
 \ 'AcceptSelection("e")': ['<c-j>', '<cr>', '<2-LeftMouse>'],
 \ 'PrtClearCache()':      ['<F4>'],
 \ }

nmap <leader>l :CtrlPBuffer<CR>
nmap <leader>f :CtrlPBufTag<CR>
nmap <leader>F :CtrlPTag<CR>
let g:ctrlp_extensions = ['tag']
"nnoremap <silent> <c-p> :call fzf#run({ 'dir': expand($HOME) }/expand($CURRENTPROJ))<CR>

""""""""""""""
" Clang Format
""""""""""""""
"autocmd FileType c,cpp,objc ClangFormatAutoEnable
nmap <leader>m :ClangFormatAutoToggle<cr>
nmap <leader>= :ClangFormat<cr>
let g:clang_format#detect_style_file = 1
let g:clang_format#code_style = "google"
let g:clang_format#style_options = {
            \ "ColumnLimit" : 120,
            \ "IndentWidth" : 4,
            \ "AccessModifierOffset" : -4,
            \ "BreakBeforeBraces" : "Allman",
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "Cpp11"}

"Look for ctags file
set tags=$HOME/$CURRENTPROJ/.git/tags;/
set statusline=%<%F%{tagbar#currenttag(':%s','','')}\ %{fugitive#statusline()}%=%([%M%R%H%W]\ %)%l,%c%V\ %P\ (%n)

"""""""""""
" Functions
"""""""""""
command Tse call TabSELinux()
command Ctse call CleanTabSELinux()

function! TabSELinux()
    :Tabularize /}\|scontext[^ ]\+\|tcontext[^ ]\+\|tclass[^ ]\+/
endfunction

function! CleanTabSELinux()
    :g!/avc.*denied/d
    :%s/^.*denied *//
    :call TabSELinux()
    :set nowrap
endfunction

set makeprg=singlefile
nmap <F6> :call SwitchStub()<CR>
nmap <F7> :call SwitchTest()<CR>
nmap <F9> :call BuildSubSystem("")<CR><CR>
nmap <F10> :call BuildFile()<CR><CR>

set shiftwidth=4
set softtabstop=4
set tabstop=4
