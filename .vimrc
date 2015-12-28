" Vundle configuration
set nocompatible
filetype off
set rtp +=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'groenewege/vim-less'
Plugin 'elzr/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-surround'

call vundle#end()
filetype plugin indent on
" end Vundle configuration

" w!! == sudo :w
cmap w!! w !sudo tee > /dev/null %

" Indentation
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set smartindent

" Filetype-specific
au FileType javascript setlocal sw=2 ts=2 sts=2
au FileType ruby setlocal sw=2 ts=2 sts=2
au FileType css setlocal sw=2 ts=2 sts=2

" Trailing whitespace
" au BufWrite * :%s/\s\+$//e

" Searching & Buffers
set hlsearch
set ignorecase
set incsearch
set path+=**
set hidden
nnoremap <C-b> :buffers<CR>:buffer<Space>
nnoremap <C-l> :cnext<CR>
nnoremap <C-k> :cprev<CR>

" Misc
syntax on
set ruler
set number
set autoread
nnoremap <S-Enter> O<Esc>j
nnoremap <CR> o<Esc>k
