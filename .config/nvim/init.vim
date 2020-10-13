" Plugin configuration
call plug#begin(stdpath('data') . '/plugged')
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'ianks/vim-tsx'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'tpope/vim-commentary'

  " Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
  Plug 'file://'.expand('~/.local/share/nvim/plugged/nvim-typescript')

  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'vim-airline/vim-airline'
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()

" Compatibility / Perf
set re=0

" deoplete
let g:deoplete#enable_at_startup=1
" nvim-typescript
let $NVIM_NODE_LOG_FILE='nvim-node.log'
let $NVIM_NODE_LOG_LEVEL='warn'
" let g:nvim_typescript#type_info_on_hold=1
let g:nvim_typescript#default_mappings=1

" YATS
let g:yats_host_keyword=0

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

" Buffers
set hidden
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
inoremap <C-b> <Esc><C-b>

" Misc
syntax on
set nowrap
set ruler
set number
set autoread
set clipboard=unnamedplus
set matchpairs+=<:>
set scrolloff=3
set signcolumn=yes

" Enter puts a new line below the current one without changing to insert mode
nnoremap <Enter> o<Esc>^$

" Colors
hi Special ctermfg=Blue
hi ColorColumn ctermbg=black
hi LineNr ctermbg=black ctermfg=darkblue
hi SignColumn ctermbg=black
hi Signs ctermbg=black
hi SpellBad cterm=underline ctermbg=none
hi Error cterm=underline ctermbg=none
hi NeomakeErrorSign ctermbg=black ctermfg=red
hi NeomakeWarningSign ctermbg=black ctermfg=yellow
hi NeomakeInfoSign ctermbg=black ctermfg=blue
hi Pmenu ctermbg=black ctermfg=red

augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
augroup end

augroup TypeScript
  au!
  au FileType typescript* setlocal cc=81 tw=80 sts=2 sw=2 fex&
  au FileType typescript* setlocal formatprg=prettier\ --parser\ typescript
  au FileType typescript* nnoremap gd :TSDef<CR>
augroup end
