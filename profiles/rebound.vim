Bundle 'kien/ctrlp.vim'
Bundle 'racer-rust/vim-racer'
Bundle 'rust-lang/rust.vim'
"Bundle 'Valloric/YouCompleteMe'
"Bundle 'scrooloose/syntastic'
"Bundle 'majutsushi/tagbar'

"au BufRead,BufNewFile *.hpp set syntax=cpp.doxygen

let g:rust_recommended_style = 0

"""""""""""""""
" YouCompleteMe
"""""""""""""""
"let g:ycm_confirm_extra_conf = 0
"let g:ycm_register_as_syntasic_checker = 0
"nmap <leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>
"let g:ycm_rust_src_path = '/home/hogklint/repos/rust-src/src'

"""""""
" CtrlP
"""""""
"let g:ctrlp_cmd="CtrlP ~/TCC_ER_CIS_SW"
"let g:ctrlp_cmd="CtrlP ".expand($HOME)."/".expand($CURRENTPROJ)
let g:ctrlp_max_height=40
let g:ctrlp_switch_buffer=2
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_dotfiles=0
"let g:ctrlp_custom_ignore='SunOS_i86pc$\|\.d$\|\.o$\|\.a$\|\.tcov$'
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
