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
set list listchars=tab:→\ ,trail:·

syntax on


com! FormatJSON %!python -m json.tool

" Навигация с учетом русских символов, учитывается командами следующее/предыдущее слово и т.п.
set iskeyword=@,48-57,_,192-255
" Удаление символов бэкспэйсом в Windows
set backspace=indent,eol,start
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
Plug 'pangloss/vim-javascript'
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
