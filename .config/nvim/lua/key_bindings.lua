local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

map('n', ',', '<Nop>')
map('n', '<C-p>', ":GFiles -co --exclude-standard<CR>")
map('n', '<C-b>', ':Buffers<CR>')
map('n', '<Tab>', ':bn<CR>')
map('n', '<S-Tab>', ':bp<CR>')
map('n', '<Leader>q', ':bp<bar>sp<bar>bn<bar>bd<CR>')
map('n', '<Enter>', 'o<Esc>^$')
map('n', '<Leader>c', ':e ~/.config/nvim/init.lua<CR>')
map('n', '<C-t>', ':NvimTreeToggle<CR>')
map('n', '<leader>t', ':r!date -Iseconds<CR>')

-- Ledger
map('n', '<C-n>', ':call ledger#entry()<CR>')

-- CoC
map('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
map('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })
map('n', 'gd', '<Plug>(coc-definition)', { silent = true })
map('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
map('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
map('n', 'gr', '<Plug>(coc-references)', { silent = true })
map('n', '<Leader>f', '<Plug>(coc-fix-current)', { silent = true })
map('n', '<Leader>a', '<Plug>(coc-codeaction-line)', { silent = true })
map('n', '<Leader><CR>', '<Plug>(coc-codelens-action)', { silent = true })
map('n', 'K', '<CMD>lua _G.show_docs()<CR>', { silent = true })
