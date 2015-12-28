" Vundle configuration
set nocompatible
filetype off
set rtp +=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle plugins
Plugin 'elzr/vim-json'
Plugin 'gmarik/Vundle.vim'
Plugin 'groenewege/vim-less'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/fzf'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'

call vundle#end()
filetype plugin indent on
" end Vundle configuration

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

" w!! == sudo :w
cmap w!! w !sudo tee > /dev/null %

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set smartindent
set formatoptions-=cro

" Filetype-specific
au FileType javascript setlocal sw=2 ts=2 sts=2
au FileType ruby setlocal sw=2 ts=2 sts=2
au FileType css setlocal sw=2 ts=2 sts=2

" Trailing whitespace
au BufWrite * :%s/\s\+$//e

" Searching & Buffers
set path=,,src/**,lib/**,test/**,spec/**,include/**
set hlsearch
set incsearch
set hidden

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

"""""""Key Mappings""""""""""
" Super enter
nnoremap <CR> o<Esc>k
" Prevent accidental helps
inoremap <F1> <Esc>
" l2vim
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
"""""""""""""""""""""""""""""

" Color column
highlight ColorColumn ctermbg=8
au BufEnter * setlocal textwidth=80 colorcolumn=+1

" TypeScript
au BufEnter *.ts setlocal textwidth=140 colorcolumn=+1 tabstop=4 shiftwidth=4 softtabstop=4

" HTML
au BufEnter *.html setlocal textwidth=0 coloccolumn= tabstop=4 shiftwidth=4 softtabstop=4
