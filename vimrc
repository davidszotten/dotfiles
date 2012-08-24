set encoding=utf-8
set nocompatible
let mapleader = ","

call pathogen#infect()



" some plugins are only needed if we're in terminal mode, e.g. miniBufExpl
if !has("gui_macvim")
    call pathogen#infect('terminal_only')
    noremap <C-L> :bn<cr>
    noremap <C-H> :bp<cr>
end

inoremap jk <ESC>


" for some reason, number of term colours aren't set properly
set t_Co=256
colorscheme molokai
set guioptions=egmrt

" highlight bg beyond column 80
if v:version >= 703
    execute "set cc=" . join(range(80, 160), ',')
end

syntax on

" One of the most important options to activate. Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
set hidden

" bash style tab completion for finding files
set wildmenu
set wildmode=list:longest


" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (turn off with :nohl)
set hlsearch

" Modelines have historically been a source of security vulnerabilities.  As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
set nomodeline

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" from coming home to vim
nnoremap / /\v
vnoremap / /\v
set gdefault
set incsearch
set showmatch
nnoremap <leader><space> :noh<cr>


" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" tabs expand to 4 spaces
set shiftwidth=4
set softtabstop=4
set expandtab

set mouse=a
set ruler

filetype on
filetype plugin on

" key remappings

" toggle autocomplete for pasting
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"remap § for typos
inoremap § <ESC>
nnoremap § <ESC>

" delete all buffers:
nnoremap <leader>w :bufdo bdelete<CR>

" backups

if v:version >= 703
    set undodir=~/.vim/tmp/undo//     " undo files
end
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set noswapfile                    " It's 2012, Vim.


" plugin settings

" scratch plugin
nnoremap <leader>s :Scratch <cr>

" yankring plugin
let g:yankring_history_dir =  expand('$HOME') . '/.vim'

" space around/after comments
let NERDSpaceDelims=1

" command-t
:set wildignore+=*.pyc,htmlcov/**,_build/**

" open files in new tabs
let g:CommandTAcceptSelectionMap = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<cr>'

" command-t requires ruby, so if it's missing, fall back to ctrlp
if !has('ruby')
    nnoremap <leader>t :CtrlP<cr>
    nnoremap <leader>b :CtrlPBuffer<cr>
end

" syntastic
let g:syntastic_enable_signs=0
let g:syntastic_check_on_open=1
let g:syntastic_python_checker = 'pyflakes'

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" delete trailing whitespace
" allow saving with trailing whitespace
let g:DeleteTrailingWhitespace = 0

" sudo-write (too easy to hit by accident, but kept here to be used as a
" reference
" command W w !sudo tee % > /dev/null

" always show tab bar
set showtabline=2

" show first line of current block for 1/2 second
nnoremap <leader>f mf [{0"fy$`f:echo @f<CR>

" autoclose fugutive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" disable automatic folding (for markdown)
autocmd Filetype mkd setlocal nofoldenable

" make tilde an operator (to allow e.g. ~w to change a whole word)
:set tildeop

" select last paste
nnoremap gp `[v`]

set listchars=tab:▸\ ,eol:¬
" Toggle [i]nvisible characters
nnoremap <leader>i :set list!<cr>
" show eol and tab chars by default
set list

" iterm2 cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" for powerline
let g:Powerline_symbols = 'fancy'
set laststatus=2
set fillchars+=stl:\ ,stlnc:\

" make it easier to make it easier to edit text.
if has("gui_macvim")
    :nnoremap <leader>ev :tabnew $MYVIMRC<cr>
else
    :nnoremap <leader>ev :e $MYVIMRC<cr>
endif
:nnoremap <leader>sv :source $MYVIMRC<cr>

let g:command_t_traverse_to_scm_root = 1

" File type specific settings

" python
augroup ft_python
    au!
    au FileType python nnoremap <leader>p Oimport ipdb; ipdb.set_trace()<ESC>
    au FileType python nnoremap <leader>P oimport ipdb; ipdb.set_trace()<ESC>
    au FileType python ab pdb import ipdb; ipdb.set_trace()
augroup END

" Reload the colorscheme whenever we write the file.
augroup color_molokai_dev
    au!
    au BufWritePost molokai.vim color molokai
augroup END
