" Vundle configuration
set nocompatible
filetype off
set rtp +=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'JulesWang/css.vim'
Plugin 'elzr/vim-json'

call vundle#end()
filetype plugin indent on
" end Vundle configuration

" powerline
set encoding=utf-8
set laststatus=2
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" Fuzzy finder
nnoremap <C-f> :GitFiles -oc<CR>
nnoremap <C-b> :Buffers<CR>

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smartindent
set formatoptions-=cro

" Trailing whitespace
au BufWrite * :%s/\s\+$//e

" Searching
set hlsearch
set incsearch

" Display hidden characters
set list
set listchars=nbsp:¬,tab:»·

" Misc
syntax on
set nowrap
set ruler
set number
set autoread
set clipboard=unnamed
set matchpairs+=<:>
set scrolloff=5

" set cursorline
" hi CursorLine cterm=NONE ctermbg=darkgrey

" l2vim
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Clear search highlighting when entering insert mode
au InsertEnter * :nohl

" Searching & Buffers
set hidden
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

inoremap <F1> <Esc>

" Super Enter!
nnoremap <Return> o<Esc>k

" Color column
highlight ColorColumn ctermbg=8

" Filetype associations
au BufEnter *.ts setlocal filetype=typescript
au BufEnter *.ts setlocal textwidth=140
au BufEnter *.ts setlocal colorcolumn=+1

au BufEnter *.html setlocal textwidth=0
au BufEnter *.html setlocal colorcolumn=

au BufEnter *.rb setlocal shiftwidth=2
au BufEnter *.rb setlocal tabstop=2
au BufEnter *.rb setlocal softtabstop=2

au BufEnter *.c setlocal sw=8 ts=8 sts=8 noet nolist
au BufEnter *.h setlocal sw=8 ts=8 sts=8 noet nolist
au BufEnter *.re setlocal sw=8 ts=8 sts=8 noet nolist syn=c
au BufEnter Makefile setlocal sw=8 ts=8 sts=8 noet nolist

let g:polyglot_disabled = ['json']
