au BufRead,BufNewFile *.hpp set syntax=cpp.doxygen

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
command Ctset call CleanTabSELinuxWithTime()

function! TabSELinux()
    :Tabularize /^ \+-\?\d\+\.\d\d\d\|{[^}]\+\|}\|scontext[^ ]\+\|tcontext[^ ]\+\|tclass[^ ]\+/
endfunction

function! CleanTabSELinux()
    :g!/avc.*denied/d

    " Without monotonic time
    :%s/^.*denied *//

    :call TabSELinux()
    :set nowrap
endfunction

function! CleanTabSELinuxWithTime()
    :g!/avc.*denied/d

    " With monotonic or wall clock time
    :%s/^\s*\(-\?[0-9\.]\+\|[0-1]\d-[0-3]\d [0-1]\d:[0-5]\d:[0-5]\d\.\d\d\d\).*denied *\(.*\)/\1 \2/

    :call TabSELinux()
    :set nowrap
endfunction

function! MoveToBottom(pattern)
    normal qkq
    ":g/a:pattern/d K
    execute "g/:". a:pattern. ":/d K"
    normal G
    normal p
endfunction

""""""
" Misc
""""""

set makeprg=singlefile
command -complete=file -nargs=+ MTB call MoveToBottom(<f-args>)
vnoremap <F6> :MTB <cword><CR>
nnoremap <F6> :MTB <cword><CR>

nnoremap <silent> <leader>a :FZF $AOSP_HOME<CR>

set shiftwidth=4
set softtabstop=4
set tabstop=4
