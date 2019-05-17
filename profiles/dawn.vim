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
let g:ctrlp_custom_ignore='\.d$\|\.o$\|\.a$\|\.tcov$\|build$\|^test$\|\.orig$'
let g:ctrlp_lazy_update=0
let g:ctrlp_prompt_mappings = {
 \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
 \ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
 \ 'PrtHistory(-1)':       ['<down>'],
 \ 'PrtHistory(1)':        ['<up>'],
 \ 'AcceptSelection("e")': ['<c-j>', '<cr>', '<2-LeftMouse>'],
 \ 'PrtClearCache()':      ['<F4>'],
 \ }

"nmap <leader>l :CtrlPBuffer<CR>
"nmap <leader>f :CtrlPBufTag<CR>
"nmap <leader>F :CtrlPTag<CR>
let g:ctrlp_extensions = ['tag']
"nnoremap <silent> <c-p> :call fzf#run({ 'dir': expand($HOME) }/expand($CURRENTPROJ))<CR>

""""""
" FZF
""""""
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()

nnoremap <silent> <C-p> :ProjectFiles<CR>
nnoremap <silent> <leader>l :Buffers<CR>
nnoremap <silent> <leader>r :History<CR>
nnoremap <silent> <leader>f :BTags<CR>

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
" vim-lsp (Language Server Protocol)
"""""""""""
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

"""""""""""
" Functions
"""""""""""
command Tse call TabSELinux()
command Ctse call CleanTabSELinux()
command Ctset call CleanTabSELinuxWithTime()

function! TabSELinux()
    :Tabularize /}\|scontext[^ ]\+\|tcontext[^ ]\+\|tclass[^ ]\+/
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

    " With monotonic time
    :%s/^\s*\([0-9\.]\+\).*denied *\(.*\)/\1 \2/

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

set makeprg=singlefile
command -complete=file -nargs=+ MTB call MoveToBottom(<f-args>)
vnoremap <F6> :MTB <cword><CR>
nnoremap <F6> :MTB <cword><CR>

set shiftwidth=4
set softtabstop=4
set tabstop=4
