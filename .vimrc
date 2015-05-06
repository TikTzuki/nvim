".vimrc
"Author: Viacheslav Lotsmanov

set nocompatible
filetype off "important for vundle

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

filetype plugin indent on "important for vundle

"vundle plugins
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'

"vundle colorschemes
Plugin 'altercation/vim-colors-solarized'

"plugins stuff
let NERDTreeIgnore = ['\.swp', '\.swo', '\.pyc', '__pycache__']
let NERDTreeShowHidden = 1 "always show hidden files in NERDTree

"load my modules
syntax on
runtime! my-modules/**/*.vim

"modules stuff
nmap <F10> <Esc>:DeleteHiddenBuffers<CR>
nmap <F9> <Esc>:ToggleTabsHL<CR>
call ToggleTabsHL()

"some vim configs

set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set noexpandtab

set hlsearch
set smartcase

set nowrap
set number
set nocursorline
set nocursorcolumn
if v:version >= 703
	set colorcolumn=80
endif

if has('mouse')
	set mouse=a
endif

set showtabline=2 "show tabs always
set fileencodings=utf8,cp1251
set modeline
set foldmethod=indent

let mapleader = ','

"reset search
map <F3> :let @/ = ""<CR>

"provide forward deleting in Insert and Command-Line modes
inoremap <C-l> <Del>
cnoremap <C-l> <Del>

"custom digraphs
digraphs '' 769 "accent
digraphs 3. 8230 "dots

"reset search hotkey (removes hilighting)
map <F3> :let @/ = ""<CR>

"vim: set noet :