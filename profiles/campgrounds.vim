Bundle 'kien/ctrlp.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'

au BufRead,BufNewFile *.hpp set syntax=cpp.doxygen

"""""""""""""""
" YouCompleteMe
"""""""""""""""
let g:ycm_confirm_extra_conf = 0
"let g:ycm_register_as_syntasic_checker = 0
nmap <leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>

"""""""
" CtrlP
"""""""
"let g:ctrlp_cmd="CtrlP ~/TCC_ER_CIS_SW"
let g:ctrlp_cmd="CtrlP ".expand($HOME)."/".expand($CURRENTPROJ)
let g:ctrlp_max_height=40
let g:ctrlp_switch_buffer=2
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_dotfiles=0
let g:ctrlp_custom_ignore='SunOS_i86pc$\|\.d$\|\.o$\|\.a$\|\.tcov$'
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

"Look for ctags file
set tags=$HOME/$CURRENTPROJ/.git/tags;/
set statusline=%<%F%{tagbar#currenttag(':%s','','')}\ %{fugitive#statusline()}%=%([%M%R%H%W]\ %)%l,%c%V\ %P\ (%n)

"""""""""""
" Functions
"""""""""""
command -complete=file -nargs=+ F call GrepTCC(<f-args>)
function! GrepTCC(...)
  if a:0 == 1
    let flag=''
    let pattern=a:1
    "let directory='~/TCC_ER_CIS_SW'
    let directory=expand($HOME)."/".expand($CURRENTPROJ)
  elseif a:0 == 2
    if a:1 =~ '^-'
      let flag=a:1
      let pattern=a:2
      let directory=expand($HOME)."/".expand($CURRENTPROJ)
    else
      let flag=''
      let pattern=a:1
      let directory=a:2
    endif
  elseif a:0 == 3
    let flag=a:1
    let pattern=a:2
    let directory=a:3
  else
    return
  endif

  "let directory=substitute(directory, '\~', '/home/jhogklin', 'ge')

  exe 'Ack --type=cpp --ignore-dir=test --ignore-dir=Stubs --ignore-dir=Stubs2 --ignore-dir=stubs --ignore-dir=stubs2 ' . flag . ' ' . pattern . ' ' . expand(directory)
  cw 10
endfunction

function! SwitchTest()
  if @% =~ 'Test\.[ch]pp$'
    ":edit "%:r.hpp"
   let test = substitute(expand("%:t:r"), "Test", '', 'g')
   let file1 = expand("%:h").'/../'.test.'.'.expand("%:e")
   exe "e ".file1
   "'.expand("%:e")
  else
    let file1 = expand("%:h").'/test/'.expand("%:t:r").'Test.'.expand("%:e")
    exe "e ".file1
    "find %:r.cpp
    "find %:t:r.cpp
  endif
endfunction

function! BuildFile()
  if @% =~ 'Test\.[ch]pp$'
    return
  endif

  cclose
  "let path = "%:p"
  exe 'cd '.expand("%:p:h")
  make "%:r"
  cw 10
  cd -
  "endif
endfunction

function! SwitchStub()
  let path = "%:p"
  let check = path.":t"
  while "/" != expand(path) && "source" != expand(check)
    let path = path.":h"
    let check = path.":t"
  endwhile
  echo expand(path)

  if "/" != expand(path)
    exe 'cd '.expand(path)
    if @% =~ '[Ss]tub\.[ch]pp$'
      let class = substitute(expand("%:t:r"), "\_\\\?\[Ss\]tub", '', 'g')
      exe 'e **/'.class.'\.cpp'
    else
      let class = expand("%:t:r")
      exe 'e [Ss]tub*/**/'.class.'*'
    endif
    cd -
  else
    echo "Stub not found"
  endif
endfunction

"function! BuildSubSystem(j)
"  if @% =~ 'Test\.[ch]pp$'
"    return
"  endif
"
"  cclose
"  let path = "%:p"
"  let check = path.":t"
"  while "/" != expand(path) && "source" != expand(check)
"    let path = path.":h"
"    let check = path.":t"
"  endwhile
"
"  if "/" != expand(path)
"    exe 'cd '.expand(path)
"    "echo expand(path)
"    "let jobs = "".a:j
"    make NO_OPTIMIZATION=Y
"    "echo jobs
"    "make -j1 NO_OPTIMIZATION=Y
"    "make -j13 NO_OPTIMIZATION=Y
"    cw 10
"    cd -
"  endif
"endfunction


"function! Test()
"  if !filereadable(@%)
"    return
"  endif
"
"  if @% =~ 'Test\.[ch]pp$'
"    let target = 'test/.out/'.expand("%:t:r").'.xml'
"  else
"    let target = 'test/.out/'.expand("%:t:r").'Test.xml'
"    "!~/TCC_SW/Tools/Tools/Scripts/build_test.sh %:r
"  endif
"  return target
"  "exe 'make '.target.' NO_OPTIMIZATION=Y'
"endfunction

set makeprg=singlefile
nmap <F6> :call SwitchStub()<CR>
nmap <F7> :call SwitchTest()<CR>
nmap <F9> :call BuildSubSystem("")<CR><CR>
nmap <F10> :call BuildFile()<CR><CR>
