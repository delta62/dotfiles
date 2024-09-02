require "config.vars"
require "config.opts"
require "config.keys"
require "config.auto"

-- leader must be mapped prior to loading lazy.nvim
require "config.lazy"

vim.cmd[[colorscheme tokyonight]]
