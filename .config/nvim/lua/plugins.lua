return require('packer').startup(function(use)
  use 'airblade/vim-gitgutter'
  use { 'folke/tokyonight.nvim', branch = 'main' }
  use 'ianks/vim-tsx'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'leafgarland/typescript-vim'
  use { 'neoclide/coc.nvim', branch = 'release'}
  use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end
  }
  use 'rust-lang/rust.vim'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
end)
