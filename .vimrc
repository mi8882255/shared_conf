set ignorecase
set number
set rnu
set hidden
set wildmenu
set hlsearch
set incsearch
set ruler
set confirm
set smartcase
set termencoding=utf8
set nocompatible
set showcmd
" Фолдинг по отсупам
set foldenable
set foldlevel=100
set foldmethod=indent
" Выключаем звуковое оповещение о достижении конца буффера, невозможности действия и т.д.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
" Поддержка мыши
set mouse=a
set mousemodel=popup
" Скрывать указатель мыши, когда печатаем
set mousehide
" Включить автоотступы
set autoindent
" Не переносить строки
set nowrap
" Преобразование Таба в пробелы
" set expandtab
" Размер табуляции по умолчанию
set shiftwidth=2
set softtabstop=2
set tabstop=2
" Формат строки состояния. Альтернативные варианты настройки `:h statusline`
set statusline=%f%h%m%r\ %4.6b\ \ %l,%c%V\ %P
set laststatus=2
" Включаем "умные" отступы, например, авто отступ после `{`
set smartindent
" Отображение парных символов
set showmatch
" Навигация с учетом русских символов, учитывается командами следующее/предыдущее слово и т.п.
set iskeyword=@,48-57,_,192-255
" Удаление символов бэкспэйсом в Windows
set backspace=indent,eol,start
" Увеличение размера истории
set history=200
" Дополнительная информация в строке состояния
set wildmenu
" Настройка отображения специальных символов
"set list listchars=tab:→\ ,trail:·

" set swap directory
set backupdir=$HOME/.vim/swapfiles//
set directory=$HOME/.vim/swapfiles//

syntax on


com! FormatJSON %!python -m json.tool

map <C-n> :NERDTreeToggle<CR>


let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:mapleader=','
map <Leader>f <Plug>(easymotion-prefix)
map <Leader>w <C-w>

" let g:ctrlp_user_command = 'find %s -type f'
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'rking/ag.vim'

" https://freshman.tech/vim-javascript/https://freshman.tech/vim-javascript/
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

call plug#end()
"
set clipboard=unnamed "sets the default copy register to be *
set clipboard=unnamedplus "sets the default copy register to be +
"
" " vmap "+y :w /dev/host_clipboard"
" " map "+p :r /dev/host_clipboard"
nnoremap <Space> i_<Esc>r
" imap <C-BS> <C-x><C-o>
" set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
inoremap <C-l> <Esc>c$;<Esc>
"inoremap <C-l> <Esc>c$;<Esc>P`[a
inoremap <C-s> <C-o>:w<CR>
inoremap <C-Left> <Esc>o

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>q  <Plug>(coc-format-selected)
nmap <leader>q  <Plug>(coc-format-selected)

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>ac  <Plug>(coc-codeaction)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nnoremap <Leader>a :Ag<Space>
nnoremap <Leader>p :CocCommand prettier.formatFile
source ~/shared_conf/.vimrc_autopaste
