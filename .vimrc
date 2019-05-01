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
Plugin 'Quramy/tsuquyomi'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'JulesWang/css.vim'
Plugin 'elzr/vim-json'
Plugin 'chooh/brightscript.vim'
Plugin 'tpope/vim-fugitive'

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
nnoremap <C-p> :GitFiles -oc --exclude-standard<CR>
nnoremap <C-t> :GitFiles -oc --exclude-standard<CR>
nnoremap <C-b> :Buffers<CR>

" Indentation
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set formatoptions-=cro

" Trailing whitespace
au BufWrite * :%s/\s\+$//e

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Display hidden characters
set list
set listchars=nbsp:¬,tab:»·

" Misc
syntax on
set nowrap
set ruler
set number
set autoread
set clipboard=unnamedplus
set matchpairs+=<:>
set scrolloff=3

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
inoremap <C-b> <Esc><C-b>

inoremap <F1> <Esc>

" Super Enter!
nnoremap <Return> o<Esc>k

" Color column
highlight ColorColumn ctermbg=8

" Wrap text in the quickix window
augroup quickfix
    autocmd!
    autocmd FileType qf set nobuflisted
    autocmd FileType qf setlocal wrap
augroup END

" Close quickfix when the current buffer is closed
" au BufUnload % ccl
" au BufUnload % lcl

" Filetype associations
au BufEnter *.ts setlocal textwidth=120
au BufEnter *.ts setlocal colorcolumn=+1
au BufEnter *.ts nnoremap gd :TsuDefinition<CR>
au BufEnter *.ts nnoremap F2 :TsuRenameSymbol<CR>
au BufEnter *.html setlocal textwidth=0
au BufEnter *.html setlocal colorcolumn=
au BufEnter *.underscore setlocal syntax=html

let g:polyglot_disabled = ['json']
