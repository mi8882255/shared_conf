set ignorecase
set number
set hidden
set wildmenu
set hlsearch
set ruler
set confirm
syntax on
map <C-n> :NERDTreeToggle<CR>


let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:mapleader=','
map <Leader>f <Plug>(easymotion-prefix)
map <Leader>w <C-w>

" let g:ctrlp_user_command = 'find %s -type f'
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip
call plug#begin('~/.vim/plugged')
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
" Plug 'ycm-core/YouCompleteMe'
Plug 'rking/ag.vim'

call plug#end()
"
set clipboard=unnamed "sets the default copy register to be *
set clipboard=unnamedplus "sets the default copy register to be +
"
" " vmap "+y :w /dev/host_clipboard"
" " map "+p :r /dev/host_clipboard"
"
