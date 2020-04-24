"au BufRead,BufNewFile *.hpp set syntax=cpp.doxygen

let g:rust_recommended_style = 0

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

""""""""""""
"" Vim-Racer
""""""""""""
let g:racer_cmd = "/home/hogklint/.cargo/bin/racer"
let g:racer_experimental_completer = 1

"Look for ctags file
"set tags=$HOME/$CURRENTPROJ/.git/tags;/
"set statusline=%<%F%{tagbar#currenttag(':%s','','')}\ %{fugitive#statusline()}%=%([%M%R%H%W]\ %)%l,%c%V\ %P\ (%n)
"
""""""""""""
"" Functions
""""""""""""
