""" Start Pathogen
call pathogen#infect()

set nocompatible

set autoindent
set smartindent

set esckeys

set magic

set ruler
set binary noeol

" for searching
set incsearch
set showmatch
set hlsearch
map <silent> <leader><space> :noh<cr>

" Save on losing focus
au FocusLost * :wa

set showmode

set title
set wildchar=<TAB>

set ignorecase
set smartcase
" set the backup dir to declutter working directory.
" two ending slashes means, full path to the actual filename
" -- thanks to indygemma
silent! !mkdir -p /tmp/vim-backup
silent! !mkdir -p /tmp/vim-swap
set ruler
silent! !mkdir -p /tmp/vim-undo
set backup
set backupdir=/tmp/vim-backup/
set directory=/tmp/vim-swap/
" Persistent undos (vim 7.3+)
set undofile
set undodir=/tmp/vim-undo/

set gdefault " default replace all in line

" use perl/python style regexp
nnoremap / /\v
vnoremap / /\v

filetype plugin indent on
filetype plugin on

syntax on

set guifont=Anonymous\ Pro:h13
inoremap # X#

inoremap jj <ESC>

" easier movement for splits
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set softtabstop=4 shiftwidth=4
set expandtab
set backspace=2 " backspace behaves properly

set background=dark
se t_Co=16
colorscheme solarized

map <Leader>p :call ShowPyFlakes()<CR>
map <Leader>a :call ShowAck()<CR>
nnoremap <leader>r :set relativenumber!<cr>
nnoremap <leader>e :set paste!<cr>
nnoremap <leader>s :set clipboard=unnamed<cr>
nnoremap <leader>d :set clipboard=''<cr>
nnoremap <leader>c :set cursorline!<cr>
nnoremap <silent> <leader>y :YRShow<cr>

function! ShowPyFlakes()
     :PyflakesUpdate
      if !exists("s:pyflakes_qf")
         :botright cwindow
      endif
endfunction

function! ShowAck()
     :Ack
endfunction

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

""""" Searching
"""""

" When you press gv you vimgrep after the selected text
nmap <leader>a <ESC>:Ack<space>
map <leader>g :call SearchForCurrentWord()<CR>


func! SearchForCurrentWord()
    :let @/=expand("<cword>")
    :vsplit
    call CmdLine("Ack \"" . @/ . "\"")
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

""" Jump to folders

command! DP :exec ":cd ~/src/distillery-deploy/ | e . "
command! DST :exec ":cd ~/src/distillery-server/distillery/ | e ."


""" Via John Resig, add some memory to Vim

" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif
 " Need to postpone using "zv" until after reading the modelines.
 autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif
augroup END

set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Make vim clipboard match Mac OS X clipboard
" set clipboard=unnamed