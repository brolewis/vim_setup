" Vim-Plug
filetype off
call plug#begin()
Plug 'nvie/vim-flake8'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'mitsuhiko/vim-jinja'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'reedes/vim-wordy'
Plug 'reedes/vim-pencil'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'maralla/completor.vim'
Plug 'ambv/black'
call plug#end()

" Windows-like behavior
behave mswin

" Basic Settings
syntax on                         " syntax highlighing
filetype on                       " try to detect filetypes
filetype plugin indent on         " enable plugins for filetype
set nocompatible                  " Don't be compatible with vi
colors zenburn                    " Awesomest theme EVAR
if has("gui_macvim")
    set guifont=Source\ Code\ Pro\ Light:h14
else
    set guifont=Source\ Code\ Pro:h12
endif
set nowrap                        " Don't wrap text
command! W :w                     " Map W to w
command! Wq :wq                   " Map Wq to wq

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
set laststatus=2                  " Show Airline
if has("gui_running")
    " GUI is running or is about to start.
    "   " Maximize gvim window.
    set lines=999 columns=999
endif

" Code folding
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0
set foldlevel=99
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

" Better Git commit messages
autocmd FileType gitcommit setlocal spell
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" Spellcheck rst files
autocmd FileType rst setlocal spell

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
    autocmd FileType python set colorcolumn=80,100
    highlight ColorColumn guibg=#262626
else
    autocmd FileType python highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    autocmd FileType python match OverLength /\%80v.\+/
endif

" Change swap path
let swap_path=$HOME . '/.vim_swaps//'
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

" Python tools
if has('python3')
  silent! python3 1
endif
autocmd FileType python map <buffer> <leader>8 :call Flake8()<CR>
autocmd BufWritePre *.py execute ':Black'
let g:pylint_map='<leader>l'
let g:pyflakes_use_quickfix=0
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1

" Prevent <F1> help
noremap <F1> <Esc>

" Git Gutter
let g:gitgutter_sign_removed_first_line = "^"
nmap <silent> ]h :<C-U>execute v:count1 . "GitGutterNextHunk"<CR>
nmap <silent> [h :<C-U>execute v:count1 . "GitGutterPrevHunk"<CR>

" Vim-Wordy
nnoremap <silent> K :NextWordy<cr>

" Vim-Pencil
let g:pencil#wrapModeDefault = 'hard'
augroup pencil
  autocmd!
  autocmd FileType markdown call pencil#init({'wrap': 'soft'})
  autocmd FileType rst call pencil#init({'wrap': 'soft'})
augroup END

set completeopt=longest


" Ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.ctrlp']
let g:ctrlp_regexp = 1
let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
let g:ctrlp_use_caching = 0


" XML Editing
nmap <silent> <leader>x :%!xmllint --format --recover - 2>/dev/null<CR>

" ctags
set tags=tags;/
