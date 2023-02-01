local opt = vim.opt
local g = vim.g

opt.re = 0

opt.backup = false
opt.writebackup = false

opt.updatetime = 300

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true

opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.number = true
opt.list = true
opt.listchars = "nbsp:¬,tab:»·"

opt.hidden = true
opt.wrap = false
opt.ruler = true
opt.number = true
opt.relativenumber=true
opt.autoread = true
opt.clipboard = "unnamedplus"
opt.matchpairs = opt.matchpairs + "<:>"
opt.scrolloff = 3
opt.signcolumn = "yes"
opt.termguicolors = true

g.airline_powerline_fonts = 1
g.airline_theme = 'simple'
-- Disable netrw, use nvim-tree instead
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.mapleader = ','
g.tokyonight_style = 'night'
