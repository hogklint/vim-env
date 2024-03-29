"set nocompatible               " be iMproved
filetype off                   " required!

call plug#begin('~/.vim/bundle')
Plug 'nomme/QFixToggle'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'markonm/traces.vim'
if executable('node')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" Host specific plugins
let hostfile=$HOME."/.vim/profiles/plug-".hostname().".vim"
if filereadable(hostfile)
  exe "source " . hostfile
endif

call plug#end()

if !has('nvim')
"Enable filetype plugin
"filetype plugin on
"filetype indent on
endif

" Highlight whitespace and long lines
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
highlight BeyondEighty ctermbg=darkred guibg=darkred
au BufWinEnter * let w:m1=matchadd('ExtraWhitespace', '\s\+$\| \+\ze\t', -1)
au BufWinEnter *.cpp,*.hpp,Makefile,*.java,*.pl,*.c,*.h let w:m2=matchadd('BeyondEighty', '\%>120v.\+', -1)


"""""
" CoC
"""""
if executable('node')
  let g:coc_global_extensions = ["coc-pyright", "coc-java", "coc-json"]
  nmap <silent> gp <Plug>(coc-diagnostic-prev)
  nmap <silent> gn <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction
endif


""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""
" Search from visual mode
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

function! s:diff_primary_branch()
  let b = system('git show origin/master 2> /dev/null')
  if v:shell_error == 0
    :Gvdiff origin/master...
  else
    :Gvdiff origin/main...
  endif
endfunction


""""""""""""""""""""""
" Custom key mappings
""""""""""""""""""""""

"Set mapleader
let mapleader = ","
let g:mapleader = ","
let maplocalleader = "-"

"Undotree
nmap <leader>u :UndotreeToggle<CR>
let g:undotree_SplitWidth=45

" Fugitive
nmap <leader>d :Gvdiff<CR>
nmap <leader>dm :call <SID>diff_primary_branch()<CR>
nmap <leader>s :Git<CR>
nmap <leader>b :Git blame -w -M<CR>
nmap <leader>e :Gedit<CR>
nnoremap <f2> :Ggrep <cword> *<CR><CR>

map <F1> :Explore<cr>
"map <F8> :set nowrap!<CR>
" Print current highlight element
map <F8> :echo synIDattr(synID(line("."),col("."),1),"name")<cr>
set pastetoggle=<F12>

" Substitue esc
imap jk <Esc>l
imap kk <Esc>l

" New row
map oo o<Esc>k
map <S-o><S-o> <S-o><Esc>j

" Treat wrapped row as unwrapped
map j gj
map k gk

vnoremap < <gv
vnoremap > >gv

"Fast saving
nmap <leader>w :w!<cr>

" Search from visual mode
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

"Map space to / and c-space to ?
map <space> /
map <c-space> ?

" Split navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Move to first none whitespace sign of row
map 0 ^

"Remove search highlight
map <silent> <leader><cr> :noh<cr>

"Quickfix list stuff
imap <leader>p <C-R>"
nmap <leader>n :cn<cr>
nmap <leader>p :cp<cr>
nmap <leader>c :cc<cr>
nmap <leader>o :QFix<cr>


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
nnoremap <silent> q/ :History/<CR>


"""""""""""""""
" Misc settings
"

"Always show the statusline
set laststatus=2

"Format the statusline
set statusline=%<%F\ %{fugitive#statusline()}\ %{coc#status()}%=%([%M%R%H%W]\ %)%l,%c%V\ %P\ (%n)

highligh CursorLine term=none cterm=none ctermbg=0
set cursorline
"set term=xterm

"Turn backup off
set nobackup
set nowritebackup
set noswapfile
set noautoread

set nofoldenable

" Set tab behaviour
set shiftwidth=2
set softtabstop=2
set tabstop=2
set smarttab
set expandtab
autocmd BufEnter *.go set noexpandtab

set autoindent
set smartindent

"C-style indeting
set cindent

set relativenumber

set fileformats=unix,dos
"nmap <leader>fd :se ff=dos<cr>
"nmap <leader>fu :se ff=unix<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set scrolloff=7

set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
set number

"Do not redraw, when running macros.. lazyredraw
set lazyredraw

"Change buffer - without saving
set hidden

"Set backspace
set backspace=eol,start,indent

set incsearch

set magic

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

set shell=zsh

"Sets how many lines of history VIM har to remember
set history=400

"Set to auto read when a file is changed from the outside
set autoread

"Set bg to dark
set background=dark

set wildignore+=*.o,*.obj,.git,*.idl

"Don't redraw while in marcro
set lazyredraw

"Enable syntax hl
syntax enable

"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

set diffopt+=algorithm:patience,indent-heuristic

" Ignore whitespace
set diffopt+=iwhiteall

" Spell check
autocmd FileType markdown setlocal spell spelllang=en_us
autocmd FileType gitcommit setlocal spell spelllang=en_us

" Host specific config files
let hostfile=$HOME."/.vim/profiles/".hostname().".vim"
if filereadable(hostfile)
  exe "source " . hostfile
endif
