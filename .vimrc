let g:mapleader = ','

" --- vim-plug: ставится сам при первом запуске
let s:plugvim = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plugvim))
  silent execute '!curl -fsLo ' . s:plugvim . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --- swap/undo в ~/.vim, каталоги создаются сами
for s:dir in ['swapfiles', 'undo']
  if !isdirectory(expand('~/.vim/' . s:dir))
    call mkdir(expand('~/.vim/' . s:dir), 'p')
  endif
endfor
set backupdir=$HOME/.vim/swapfiles//
set directory=$HOME/.vim/swapfiles//
set undodir=$HOME/.vim/undo//
set undofile

set encoding=utf-8
set ignorecase
set smartcase
set number
set rnu
set hidden
set wildmenu
set hlsearch
set incsearch
set ruler
set confirm
set showcmd
" Фолдинг по отступам
set foldenable
set foldlevel=100
set foldmethod=indent
" Без звуковых оповещений
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
" Мышь
set mouse=a
set mousemodel=popup
set mousehide
" Отступы
set autoindent
set smartindent
set shiftwidth=2
set softtabstop=2
set tabstop=2
" set expandtab
set nowrap
set showmatch
set backspace=indent,eol,start
set history=200
" Строка состояния
set statusline=%f%h%m%r\ %4.6b\ \ %l,%c%V\ %P
set laststatus=2
" Для coc: быстрее CursorHold, колонка знаков всегда видна
set updatetime=300
set signcolumn=yes
"set list listchars=tab:→\ ,trail:·

" Системный буфер обмена (на macOS работает unnamed, на Linux unnamedplus)
set clipboard^=unnamed,unnamedplus

syntax on
filetype plugin indent on

com! FormatJSON %!python3 -m json.tool

" --- plugins
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
call plug#end()

" coc-расширения ставятся автоматически (нужен node)
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-eslint', 'coc-prettier']

if executable('rg')
  let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git'"
endif

" --- mappings
map <C-n> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>
nnoremap <Leader>a :Rg<Space>
map <Leader>f <Plug>(easymotion-prefix)
map <Leader>w <C-w>

nnoremap <Space> i_<Esc>r
inoremap <C-l> <Esc>c$;<Esc>
inoremap <C-s> <C-o>:w<CR>
inoremap <C-Left> <Esc>o
vnoremap <C-y> "+y

" --- coc (API coc#pum вместо pumvisible, актуальная версия coc)
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation() abort
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>q  <Plug>(coc-format-selected)
nmap <leader>q  <Plug>(coc-format-selected)
nmap <leader>qf <Plug>(coc-fix-current)
nmap <leader>ac <Plug>(coc-codeaction-cursor)
xmap <leader>as <Plug>(coc-codeaction-selected)
nnoremap <Leader>p :CocCommand prettier.formatFile<CR>

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
