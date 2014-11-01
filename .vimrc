" Vundle configuration
set nocompatible
filetype off
set rtp +=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'groenewege/vim-less'
Plugin 'elzr/vim-json'

call vundle#end()
filetype plugin indent on
" end Vundle configuration

" Indentation
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent

" Trailing whitespace
au BufWrite * :%s/\s\+$//e

" Searching
set hlsearch
set ignorecase
set incsearch

" Misc
syntax on
set number
set autoread

" Searching & Buffers
set path+=**
set hidden
nnoremap <C-b> :buffers<CR>:buffer<Space>
nnoremap <C-l> :cnext<CR>
nnoremap <C-k> :cprev<CR>
