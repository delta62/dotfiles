require('nvim-web-devicons').setup { }

require('nvim-tree').setup {
    view = {
        width = 35
    }
}

require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
}
