return require('packer').startup(function(use)
  use 'airblade/vim-gitgutter'
  use 'digitaltoad/vim-pug'
  use 'Luxed/ayu-vim'
  use { 'folke/tokyonight.nvim', branch = 'main' }
  use 'ianks/vim-tsx'
  use 'junegunn/fzf.vim'
  -- use 'mattn/emmet-vim'
  use 'mhinz/vim-startify'
  use {
      'nvim-tree/nvim-tree.lua',
      requires = { 'nvim-tree/nvim-web-devicons' }
  }
  use 'leafgarland/typescript-vim'
  use 'ledger/vim-ledger'
  use { 'neoclide/coc.nvim', branch = 'release'}
  use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end
  }
  use 'rust-lang/rust.vim'
  use 'tikhomirov/vim-glsl'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'mustache/vim-mustache-handlebars'
end)
