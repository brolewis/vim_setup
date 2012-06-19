" Pathogen
filetype off
call pathogen#infect()
call pathogen#helptags()

" Windows-like behavior
source $VIMRUNTIME/mswin.vim
behave mswin

" Basic Settings
syntax on                  " syntax highlighing
filetype on                " try to detect filetypes
filetype plugin indent on  " enable plugins for filetype
set nocompatible           " Don't be compatible with vi
colors zenburn             " Awesomest theme EVAR
set guifont=Consolas:h12   " BEST. FONT. EVER.
set nowrap                 " Don't wrap text
" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Line Numbering
set number                 " Display line numbers
set ruler                  " Display cursor position
set title                  " show title in console title bar
let &titleold='bash'       " revert title to 'bash'
set cursorline             " Highlight the current line
set spelllang=en_us        " Set spell checking language

" Menu Completion
set wildmenu               " Menu completion in command mode on <Tab>
set wildmode=longest,full  " <Tab> cycles between all matching choices.
set wildignore=*.pyc,*.pyo,*.pyd

" GUI Layout
set guioptions-=r          " Hide the right-hand scroll bar
set guioptions-=l          " Hide the left-hand scroll bar
set guioptions-=T          " Hide the toolbar
set guioptions-=m          " Hide the menu bar
set tabpagemax=100         " Increase max tab pages

" Search
set hlsearch               " Highlight search terms
set incsearch              " Dynamically highlight as typed
set ignorecase             " Ignore case when searching
set smartcase              " Case sensitive when caps are present

" Tabs and Spaces
set expandtab              " Convert tab to spaces
set tabstop=4              " Number of spaces for a tab
set shiftwidth=4           " Number of spaces for indentation
set shiftround             " indent/outdent to nearest tabstops
set autoindent             " Auto indent
set list                   " Print all characters
set listchars=tab:>-       " Show tab chars clearly

" Set leader charachter to <space>
let mapleader = " "

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Show characters that go over 79 chars, ignoring XML and HTML
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
fun! UpdateMatch()
    if &ft !~ '^\%(html\|xml\)$'
        match OverLength /\%80v.\+/
    else
        match NONE
    endif
endfun
autocmd BufEnter,BufWinEnter * call UpdateMatch()

" External backup dir
if has("win32")
    let tmppath="$TMP/vimswaps"
else
    let tmppath="/tmp/vimswaps"
endif
execute "set backupdir=".tmppath
execute "set directory=".tmppath

" Toggle Line Numbering mode
function! g:ToggleNuMode()
    if(&rnu == 1)
        set nu
    else
        set rnu
    endif
endfunc
nnoremap <C-l> :call g:ToggleNuMode()<CR>

" NERDTree
map <F2> :NERDTreeToggle Workspace<CR>
map <F12> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.vim#', '\~$', '\.pyc']

" Python tools
let g:pep8_map='<leader>8'
let g:pylint_map='<leader>l'

" Toggle Gundo
nnoremap <leader>u :GundoToggle<CR>

" Supertab
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menu,longest,preview
" Close the scratch window after autocomplete finished
autocmd CursorMovedI * if pumvisible() == 0 && bufname("%") != "[Command Line]"|pclose|endif
autocmd InsertLeave * if pumvisible() == 0  && bufname("%") != "[Command Line]"|pclose|endif

" MiniBufExplorer
let g:miniBufExplMapCTabSwitchBufs=1  " C-Tab and C-S-Tab for buffer switching
let g:miniBufExplCheckDupeBufs=0      " Don't check for duplicates (faster)
let g:miniBufExplForceSyntaxEnable=1  " Try to force syntax highlighting
