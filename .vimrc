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
Plugin 'JulesWang/css.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'elzr/vim-json'
Plugin 'jiangmiao/auto-pairs'

call vundle#end()
filetype plugin indent on
" end Vundle configuration

" vimproc
set rtp+=~/.vim/manual/vimproc.vim

" powerline
set encoding=utf-8
set laststatus=2
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" Fuzzy finder
nnoremap <C-f> :FZF<Space>src/<CR>
function! s:buflist()
    redir => ls
    silent ls
    redir END
    return split(ls, '\n')
endfunction

function! s:bufopen(e)
    execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <C-b> :call fzf#run({
\   'source':   reverse(<sid>buflist()),
\   'sink':     function('<sid>bufopen'),
\   'options':  '+m -i',
\   'down':     len(<sid>buflist()) + 2
\ })<CR>

" Tsuquyomi
nnoremap <F2> :TsuquyomiRenameSymbol<CR>

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
set path=,,src/**,lib/**,test/**,spec/**
set hlsearch
set incsearch

" Display hidden characters
set list
set listchars=nbsp:¬,tab:»·

" Misc
syntax on
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

let g:polyglot_disabled = ['json']
