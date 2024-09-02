return {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = 'VeryLazy',
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    lazy = vim.fn.argc(-1) == 0,
    init = function(plugin)
        require('lazy.core.loader').add_to_rtp(plugin)
        require('nvim-treesitter.query_predicates')
    end,
    config = function(_, opts)
        if type(opts.ensure_installed) == 'table' then
            opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
        end
        require('nvim-treesitter.configs').setup(opts)
    end
}
