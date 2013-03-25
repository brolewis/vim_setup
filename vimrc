" Pathogen
filetype off
call pathogen#infect()
call pathogen#helptags()

" Windows-like behavior
source $VIMRUNTIME/mswin.vim
behave mswin

" Basic Settings
syntax on                         " syntax highlighing
filetype on                       " try to detect filetypes
filetype plugin indent on         " enable plugins for filetype
set nocompatible                  " Don't be compatible with vi
colors zenburn                    " Awesomest theme EVAR
set guifont=Consolas:h12          " BEST. FONT. EVER.
set nowrap                        " Don't wrap text
command! W :w                     " Map W to w

" Moving around, editing
set number                        " Display line numbers
set ruler                         " Display cursor position
set title                         " show title in console title bar
let &titleold='bash'              " revert title to 'bash'
set cursorline                    " Highlight the current line
set showmatch                     " Briefly jump to a paren once it's balanced
set backspace=indent,eol,start    " Intuitive backspacing in insert mode
set spelllang=en_us               " Set spell checking language
set tildeop                       " Tilde is now an operation

" Menu Completion
set wildmenu                      " Menu completion in command mode on <Tab>
set wildmode=longest,full         " <Tab> cycles between all matching choices.
set wildignore=*.pyc,*.pyo,*.pyd  " Ignore compiled python files

" GUI Layout
set guioptions-=r                 " Hide the right-hand scroll bar
set guioptions-=l                 " Hide the left-hand scroll bar
set guioptions-=T                 " Hide the toolbar
set guioptions-=m                 " Hide the menu bar
set tabpagemax=100                " Increase max tab pages

" Code folding
set foldmethod=indent             " Fold code on indent
set foldlevel=99                  " Open the file with all code unfolded
map <leader>f za                  " Remap code folding key

" Vim Tab behavior
map <silent> <C-Tab> :tabnext<CR>
imap <silent> <C-Tab> <Esc>:tabnext<CR>
map <silent> <C-S-Tab> :tabprevious<CR>
imap <silent> <C-S-Tab> <Esc>:tabprevious<CR>
map <silent> <C-t> :tabnew<CR>
imap <silent> <C-t> <Esc><C-t>

" Search
set hlsearch                      " Highlight search terms
set incsearch                     " Dynamically highlight as typed
set ignorecase                    " Ignore case when searching
set smartcase                     " Case sensitive when caps are present

" Tabs and Spaces
set expandtab                     " Convert tab to spaces
set tabstop=4                     " Number of spaces for a tab
set shiftwidth=4                  " Number of spaces for indentation
set shiftround                    " indent/outdent to nearest tabstops
set autoindent                    " Auto indent
set list                          " Print all characters
set listchars=tab:>-              " Show tab chars clearly

" for when we forget to use sudo to open/edit a file
cmap w!! w !sudo tee % >/dev/null

" open/close the quickfix window
nmap <leader>c :copen<CR>
nmap <leader>cc :cclose<CR>

" Set leader charachter to <space>
let mapleader = " "

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Show characters that go over 79 chars for Python files
if exists('+colorcolumn')
    autocmd FileType python set colorcolumn=80
    highlight ColorColumn guibg=#262626
else
    autocmd FileType python highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    autocmd FileType python OverLength /\%80v.\+/
endif

" External backup dir
let swap_path=$HOME . '/.vim_swaps'
if empty(glob(swap_path))
    call mkdir(swap_path, 'p')
endif

execute "set backupdir=".swap_path
execute "set directory=".swap_path

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
autocmd FileType python map <buffer> <leader>8 :call Flake8()<CR>
let g:pylint_map='<leader>l'
let g:pyflakes_use_quickfix=0

" Toggle Gundo
nnoremap <leader>u :GundoToggle<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Jedi Vim
let g:jedi#popup_on_dot = 0

" Prevent <F1> help
noremap <F1> <Esc>

" Git Gutter
if has('gui_win32')
    let g:gitgutter_enabled = 0
endif
map <F10> :GitGutterToggle<CR>
nmap <silent> ]h :<C-U>execute v:count1 . "GitGutterNextHunk"<CR>
nmap <silent> [h :<C-U>execute v:count1 . "GitGutterPrevHunk"<CR>
