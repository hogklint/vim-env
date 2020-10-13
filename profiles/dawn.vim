au BufRead,BufNewFile *.hpp set syntax=cpp.doxygen

highligh CursorLine term=none cterm=none ctermbg=0

"""""
" CoC
"""""
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

""""""
" FZF
""""""
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()

nnoremap <silent> <C-p> :ProjectFiles<CR>
nnoremap <silent> <leader>a :FZF $AOSP_HOME<CR>
nnoremap <silent> <leader>l :Buffers<CR>
nnoremap <silent> <leader>r :History<CR>
nnoremap <silent> <leader>f :BTags<CR>
nnoremap <silent> q/ :History/<CR>

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

set shiftwidth=4
set softtabstop=4
set tabstop=4

" Ignore whitespace
set diffopt+=iwhiteall
