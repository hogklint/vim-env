"call pathogen#infect()
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'vim-scripts/QFixToggle'
Bundle 'tpope/vim-fugitive'
Bundle 'Valloric/YouCompleteMe'
"Bundle 'scrooloose/syntastic'

"Enable filetype plugin
filetype plugin on
filetype indent on

"set wildignore+=*.o,*.obj,.git,*[Ss]tub*,*Test*,*.idl,*.xml
set wildignore+=*.o,*.obj,.git,*Test*,*.idl,*.xml

nmap <leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_confirm_extra_conf = 0

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

function! Test()
  if !filereadable(@%)
    return
  endif

  if @% =~ 'Test\.[ch]pp$'
    let target = 'test/.out/'.expand("%:t:r").'.xml'
  else
    let target = 'test/.out/'.expand("%:t:r").'Test.xml'
    "!~/TCC_SW/Tools/Tools/Scripts/build_test.sh %:r
  endif
  return target
  "exe 'make '.target.' NO_OPTIMIZATION=Y'
endfunction

function! SwitchSourceHeader()
   "update!
   if (expand ("%:e") == "cpp")
     ":edit "%:r.hpp"
     find %:r.hpp
   elseif (expand ("%:e") == "hpp")
     find %:r.cpp
     "find %:t:r.cpp
   endif
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
nmap <F5> :call SwitchSourceHeader()<CR>
nmap <F6> :call SwitchStub()<CR>
nmap <F7> :call SwitchTest()<CR>
map <F8> :set nowrap!<CR>

imap jk <Esc>l
imap kk <Esc>l
map oo o<Esc>k
map <S-o><S-o> <S-o><Esc>j
map j gj
map k gk
vnoremap < <gv
vnoremap > >gv
set term=xterm

" Lusty Juggler
"unmap <leader>lj
"let g:LustyJugglerSuppressRubyWarning = 1
"let g:LustyJugglerDefaultMappings = 0
"nnoremap <leader>l :LustyJuggler<CR>
"nnoremap <leader>j :LustyJugglerPrevious<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set the font
set gfn=Monospace\ 11
"set gfn=Bitstream\ Vera\ Sans\ Mono:h11

"Set bg to dark
set background=dark

let psc_style='cool'
"source ~/vim_local/ps_color.vim
"colorscheme grim

"Enable syntax hl
syntax enable

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
"map <leader>1 :set syntax=cheetah<cr>
"map <leader>2 :set syntax=xhtml<cr>
"map <leader>3 :set syntax=python<cr>
"map <leader>$ :syntax sync fromstart<cr>

autocmd BufEnter * :syntax sync fromstart

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..
set nocompatible

set makeprg=singlefile
nmap <F9> :call BuildSubSystem("")<CR><CR>
nmap <F10> :call BuildFile()<CR><CR>
"nmap <F10> :make test -j13 NO_OPTIMIZATION=Y<CR> :cw 10<CR>
nmap <F11> :call BuildUnitTest()<CR>
cabbrev cleansyslog :%s/\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d.\d\d+\d\d:\d\d tcc1a fspA\[\d\{1,5\}\]: \[ID \d\d\d\d\d\d user.\(info\\|debug\\|warning\\|crit\\|whitebox\)\] ,10040,A,//
"let g:clang_auto_select=1
"let g:clang_complete_auto=1
"let g:clang_complete_copen=1
"let g:clang_hl_errors=1
"let g:clang_snippets=1
"let g:clang_snippets_engine="clang_complete"
"let g:clang_conceal_snippets=1
"let g:clang_exec="clang"
"let g:clang_auto_user_options="path, .clang_complete"
"let g:clang_sort_algo="priority"
"let g:clang_complete_macros=1
"let g:clang_complete_patterns=0
"let g:SuperTabDefaultCompletionType="context"

"let g:clang_periodic_quickfix=1
"let g:clang_user_options='|| exit 0'
"let g:clang_use_library=1
"let g:clang_library_path="/usr/lib/llvm"
"nmap <Leader>q :call g:ClangUpdateQuickFix()<CR>

"let g:clic_filename="/path/to/index.db"
"nnoremap <Leader>r :call ClangGetReferences()<CR>
"nnoremap <Leader>d :call ClangGetDeclarations()<CR>
"nnoremap <Leader>s :call ClangGetSubclasses()<CR>

""""" CtrlP
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

function! BuildSubSystem(j)
  if @% =~ 'Test\.[ch]pp$'
    return
  endif

  cclose
  let path = "%:p"
  let check = path.":t"
  while "/" != expand(path) && "source" != expand(check)
    let path = path.":h"
    let check = path.":t"
  endwhile

  if "/" != expand(path)
    exe 'cd '.expand(path)
    "echo expand(path)
    "let jobs = "".a:j
    make NO_OPTIMIZATION=Y
    "echo jobs
    "make -j1 NO_OPTIMIZATION=Y
    "make -j13 NO_OPTIMIZATION=Y
    cw 10
    cd -
  endif
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

function! BuildUnitTest()
  if !filereadable(@%)
    return
  endif

  if @% =~ 'Test\.[ch]pp$'
    let unit = substitute(expand("%:t:r"), "Test", '', 'g')
    let path = expand("%:p:h:h")
  else
    let unit = expand("%:t:r")
    let path = expand("%:p:h")
  endif

  if isdirectory(path)
    exe 'cd '.path
    let testrun = system("~/local/Tools/Scripts/build_test.sh ".unit)

    " set up a new buffer (for debugging)
    below 15new
    setlocal buftype=nofile bufhidden=hide noswapfile
    "file unittestbuffer

    put = testrun
    1d
    if testrun !~ 'There were test build error'
      :$
    endif
    cd -
  else
    echo "Directory does not exist!"
  endif
endfunction

"Set shell to be bash
set shell=zsh

"Sets how many lines of history VIM har to remember
set history=400

"Set to auto read when a file is changed from the outside
set autoread

"Have the mouse enabled all the time:
"set mouse=a

"Set mapleader
let mapleader = ","
let g:mapleader = ","
let g:netrw_sort_sequence = "[\/]$,*,\.bak$,\.o$,\.h$,\.info$,\.swp$,\.obj$"

" CtrlP
nmap <leader>l :CtrlPBuffer<CR>
nmap <leader>f :CtrlPBufTag<CR>
nmap <leader>F :CtrlPTag<CR>
let g:ctrlp_extensions = ['tag']

"Fugitive
nmap <leader>d :Gdiff<CR>
nmap <leader>s :Gstatus<CR>
nmap <leader>b :Gblame<CR>
nmap <leader>e :Gedit<CR>

"Fast saving
nmap <leader>w :w!<cr>
"unmap <leader>e

if has("gui_running")
   if $SHELL =~ '/\(sh\|csh\|bash\|tcsh\|zsh\)$'
      let s:path = system("echo echo VIMPATH'${PATH}' | $SHELL -l")
      let $PATH = matchstr(s:path, 'VIMPATH\zs.\{-}\ze\n')
   endif
   autocmd VimEnter * if getcwd()=="/" | if strlen(@%) | cd %:p:h | else | cd | endif | endif
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local source plugin-files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! SourceFile(path, file)
   "Path should be /blah/blah/blah
   let path_file = a:path . '/' . a:file
   exe "source " . path_file
endfunction

function! SourceDir(path)
   "Path should be /blah/blah/blah
   let files = system("ls " . a:path)
   let pattern = '[A-Za-z0-9-_]\+.vim'
   while match(files, pattern) != -1
      let file = matchstr(files, pattern)
      let files = substitute(files, pattern . '\n', '', '')
      call SourceFile(a:path, file)
   endwhile
endfunction

"Source files frenzy
call SourceDir("~/.vim/plugin")


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetypes
set ffs=unix,dos,mac

"nmap <leader>fd :se ff=dos<cr>
"nmap <leader>fu :se ff=unix<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
"set whichwrap+=<,>,h,l,[,]

"Ignore case when searching
set incsearch

"Set magic on
set magic

"Short messages .. to avoid.. press a key prompt
"set shortmess=at

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

"How many tenths of a second to blink
set mat=2

"Highlight search things
set hlsearch


""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""
"Always hide the statusline
set laststatus=2

"function! CurDir()
"   let curdir = substitute(getcwd(), '/Users/amirsalihefendic/', "~/", "g")
"   return curdir
"endfunction

"Format the statusline
"set statusline=\ File:\ %F%m%r%h\ %w\ \ \ Current\ dir:\ %r%{CurDir()}%h
set statusline=%<%F\ %{fugitive#statusline()}%=%([%M%R%H%W]\ %)%l,%c%V\ %P\ (%n)

""""""""""""""""""""""""""""""
" Visual
""""""""""""""""""""""""""""""
" From an idea by Michael Naumann, Jürgen Krämer.
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    else
        execute "normal /" . l:pattern . "^M"
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

set cursorline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map space to / and c-space to ?
map <space> /
map <c-space> ?

" Set window name in tmux
function! SetTitle(reset)
  if ("" == expand($TMUX))
    return
  endif

  if ("reset" == a:reset)
    silent execute "!tmux set-window-option automatic-rename on"
  else
    let file = expand("%:t")
    silent execute "!settitle ". file
  endif
endfunction
autocmd BufEnter * call SetTitle("set")
autocmd VimLeave * call SetTitle("reset")

"Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Actually, the tab does not switch buffers, but my arrows. edited in miniBuffer
let g:miniBufExplMapCTabSwitchBufs = 1
map <leader>bd :Bclose<cr>
"map <down> <leader>bd

"Moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir
"autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

"Switch to current dir
"map <leader>cd :cd %:p:h<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
")
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $w <esc>`>a"<esc>`<i"<esc>

"Map auto complete of (, ", ', [
inoremap $1 ()<esc>:let leavechar=")"<cr>i
inoremap $2 []<esc>:let leavechar="]"<cr>i
inoremap $3 {}<esc>:let leavechar="}"<cr>i
inoremap $q ''<esc>:let leavechar="'"<cr>i
inoremap $w ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(vim\)\@! inoremap " ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(txt\)\@! inoremap ' ''<esc>:let leavechar="'"<cr>i

imap <m-l> <esc>:exec "normal f" . leavechar<cr>a


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Comments
autocmd BufNewFile,BufRead *.js,*.htc,*.c,*.tmpl inoremap $c /***<cr><BS>***/<esc>O


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command-line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cno $d e ~/Desktop/
cno $s e static/


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Buffer - "hide" :)
"map <F8> ggVGg?''
map <F8> :echo synIDattr(synID(line("."),col("."),1),"name")<cr>

"Use the arrows to something usefull
map <F1> :Explore<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
set noswapfile
set noar

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"This one is simple, don't use folding :)
set nofen


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set smarttab
"set tw=80
"set lbr
set et

   """"""""""""""""""""""""""""""
   " Indent
   """"""""""""""""""""""""""""""
   "Auto indent
   set ai

   "Smart indet
   set si

   "C-style indeting
   set cindent

   "Wrap lines
"   set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   """"""""""""""""""""""""""""""
   " Tag list (ctags)
   """"""""""""""""""""""""""""""
   "let Tlist_Ctags_Cmd = "~/local/bin/ctags"
   "let Tlist_Ctags_Cmd = "ctags"
   "let Tlist_Sort_Type = "name"
   "let Tlist_Use_Right_Window = 1
   "let Tlist_Show_Menu = 1
   ""source $HOME/.vim/plugins/taglist.vim
   "map <silent>t :Tlist<cr>
   set tags=$HOME/$CURRENTPROJ/.git/tags;/
   "nmap <leader>tp :tp<cr>
   "nmap <leader>np :np<cr>


   """"""""""""""""""""""""""""""
   " ShowMarks configurations
   """"""""""""""""""""""""""""""
   "let g:showmarks_ignore_type="hpr"
   "let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
   "hi default ShowMarksHLl guifg=white guibg=#333333
   "map mh <leader>mh
   "let g:showmarks_hlline_lower=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype generic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   """"""""""""""""""""""""""""""
   " VIM
   """"""""""""""""""""""""""""""
   autocmd BufRead,BufNew *.vim map <buffer> <leader><space> :w!<cr>:source %<cr>

   """"""""""""""""""""""""""""""
   " Python section
   """"""""""""""""""""""""""""""
   "Run the current buffer in python - ie. on leader+space
   autocmd BufNewFile,BufRead *.py map <buffer> <leader><space> :w!<cr>:!python %<cr>

   "Set some bindings up for 'compile' of python
   autocmd BufNewFile,BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
   autocmd BufNewFile,BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
   autocmd BufNewFile,BufRead *.py nmap <buffer> <F8> :w!<cr>:make<cr>
   autocmd BufNewFile,BufRead *.py map <buffer> <leader>c :cope 5<cr>

   "Python iMaps
   au BufNewFile,BufRead *.py inoremap <buffer> $r return
   au BufNewFile,BufRead *.py inoremap <buffer> $c ##<cr>#<space><cr>#<esc>kla
   au BufNewFile,BufRead *.py inoremap <buffer> $i import
   au BufNewFile,BufRead *.py inoremap <buffer> $p print
   au BufNewFile,BufRead *.py inoremap <buffer> $d """<cr>"""<esc>O

   "Spacings
   highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
   highlight BeyondEighty ctermbg=darkred guibg=darkred
	 if version < 701
		 "Vim < 7.1.40
		 syn match ExtraWhitespace /\s\+$\| \+\ze\t/
		 syn match BeyondEighty /\%>80v.\+/
		 au BufRead,BufNewFile * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
		 au BufRead,BufNewFile * syn match BeyondEighty /\%>80v.\+/
	 else
     "Vim >= 7.1.40
		 au BufWinEnter * let w:m1=matchadd('ExtraWhitespace', '\s\+$\| \+\ze\t', -1)
		 au BufWinEnter *.cpp,*.hpp,Makefile,*.java,*.pl,*.py,*.c,*.h let w:m2=matchadd('BeyondEighty', '\%>80v.\+', -1)
	 endif

   """"""""""""""""""""""""""""""
   " Snippets for Python, JavaScript and HTML
   """""""""""""""""""""""""""""""
   "You can use <c-j> to goto the next <++> - it is pretty smart ;)
   "Python
   autocmd BufNewFile,BufRead *.py inorea <buffer> cfun <c-r>=IMAP_PutTextWithMovement("def <++>(<++>):\n<++>\nreturn <++>")<cr>
   autocmd BufRead,BufNewFile *.py inorea <buffer> cclass <c-r>=IMAP_PutTextWithMovement("class <++>:\n<++>")<cr>
   autocmd BufRead,BufNewFile *.py inorea <buffer> cfor <c-r>=IMAP_PutTextWithMovement("for <++> in <++>:\n<++>")<cr>
   autocmd BufRead,BufNewFile *.py inorea <buffer> cif <c-r>=IMAP_PutTextWithMovement("if <++>:\n<++>")<cr>
   autocmd BufRead,BufNewFile *.py inorea <buffer> cifelse <c-r>=IMAP_PutTextWithMovement("if <++>:\n<++>\nelse:\n<++>")<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove search highlight
map <silent> <leader><cr> :noh<cr>

"Quickfix list stuff
imap <leader>p <C-R>"
nmap <leader>n :cn<cr>
nmap <leader>p :cp<cr>
nmap <leader>c :cc<cr>
nmap <leader>o :QFix<cr>
"inoremap [C 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F12>

"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

set relativenumber
