" Plugin configuration
call plug#begin(stdpath('data') . '/plugged')
  Plug 'ARM9/snes-syntax-vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  Plug 'ianks/vim-tsx'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'leafgarland/typescript-vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'rust-lang/rust.vim'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Compatibility / Perf
set re=0

" Airline
let g:airline_powerline_fonts = 1

" Key mappings
nnoremap , <Nop>
let mapleader = ","

" Fuzzy finder
nnoremap <silent> <C-p> :call fzf#run({'source': 'git ls-files -co --exclude-standard', 'sink': 'e', 'window': '30new'})<CR>
nnoremap <C-b> :Buffers<CR>

" Coc
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> <Leader>f <Plug>(coc-fix-current)
nnoremap <silent> <Leader>a <Plug>(coc-codeaction-line)
nnoremap <silent> <Leader><CR> <Plug>(coc-codelens-action)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

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
nnoremap <Leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Misc
syntax on
set nowrap
set ruler
set number
set relativenumber
set autoread
set clipboard=unnamedplus
set matchpairs+=<:>
set scrolloff=3
set signcolumn=yes

" Enter puts a new line below the current one without changing to insert mode
nnoremap <Enter> o<Esc>^$
nnoremap <Leader>c :e ~/.config/nvim/init.vim<CR>

" Theme
set termguicolors
let g:tokyonight_style = "night"
colorscheme tokyonight
let g:airline_theme = "simple"

" NvimTree
nnoremap <C-t> :NvimTreeToggle<CR>

lua << EOF
require'nvim-web-devicons'.setup {
}

require'nvim-tree'.setup {
    view = {
        width = 35
    }
}
EOF

" TreeSitter
lua << EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
}
EOF

augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
augroup end

augroup TypeScript
  au!
  au FileType typescript* setlocal cc=81 tw=80 sts=2 sw=2 fex&
  au FileType typescript* setlocal formatprg=prettier\ --parser\ typescript
augroup end

augroup Rust
    au!
    au FileType rust setlocal formatprg=cargo\ fmt
augroup end

augroup lalrpop
    au!
    au BufNewFile,BufRead *.lalrpop setlocal syntax=rust
augroup end

augroup snes
    au!
    au BufNewFile,BufRead *.asm,*.inc set filetype=snes
augroup end
