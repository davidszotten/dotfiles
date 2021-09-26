set rtp-=~/.config/nvim
set rtp-=~/.config/nvim/after
set rtp+=~/dotfiles/second-vim

let mapleader = ","

call plug#begin('~/dotfiles/second-vim/plugged')
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'
    Plug 'Yggdroot/indentLine'
    Plug 'airblade/vim-gitgutter'
    Plug 'altercation/vim-colors-solarized'
    Plug 'davidszotten/vim-trailing-whitespace'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'maxbrunsfeld/vim-yankstack'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-treesitter/nvim-treesitter/'
    Plug 'shadmansaleh/lualine.nvim' " fork for now
    Plug 'tpope/vim-commentary/'
call plug#end()

set background=dark
let g:solarized_termtrans = 1 " This gets rid of the grey background
silent! colorscheme solarized

" allow per-project vimrc
" set exrc
" set secure  " make them slightly more secure

" stop syntax highlighting hiding characters in e.g. markdown or json docs
set conceallevel=0

" skip the splash screen
set shortmess+=I

set cc=80

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
defaults={
  mappings={
    i={
        ["<esc>"]=actions.close
    },
  },
  layout_config = {
    horizontal = {
      preview_cutoff = 25,
      }   },
  path_display = { "truncate" }
}}
EOF

nnoremap <silent> <leader>t :Telescope find_files theme=get_ivy find_command=rg,--files,--hidden,--follow,--glob,!.git/*<cr>
nnoremap <silent> <leader>b :Telescope buffers theme=get_ivy<cr>
nnoremap <silent> <leader>m :Telescope oldfiles theme=get_ivy<cr>

lua << EOF
require('nvim-treesitter.configs').setup {
 ensure_installed = "maintained",
  context_commentstring = {
    enable = true
  }
}
EOF


" tabs expand to 4 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

lua << EOF
require('lualine').setup {
    options={
    theme = 'powerline',
    -- section_separators = {'', ''},
    -- component_separators = {'', ''},
    }}
EOF

set undofile
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set noswapfile                    " It's 2012, Vim.

set number
