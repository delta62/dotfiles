require('nvim-web-devicons').setup { }

require('nvim-tree').setup {
    filters = { custom = { "^.git$" } },
    renderer = {
        add_trailing = true,
        group_empty = true,
        highlight_git = true,
        icons = {
            show = {
                git = true
            },
        },
    },
    update_focused_file = {
        enable = true
    },
    view = {
        width = 35
    },
}

require('nvim-treesitter.configs').setup {
    ensure_installed = { 'lua', 'rust' },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
}
