local function nmap(lhs, rhs, opts)
    local options = { noremap = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap('n', lhs, rhs, options)
end

nmap(',', '<Nop>')
nmap('<Tab>', ':bn<CR>')
nmap('<Shift-Tab>', ':bp<CR>')
nmap('<Enter>', 'o<Esc>^$')
nmap('<Leader>b', ':NvimTreeToggle<CR>', { silent = true })
nmap('<Leader>t', ':r!date -Iseconds<CR>')

-- Telescope
nmap('<C-p>', "<Cmd>Telescope find_files<CR>")
nmap('<C-b>', '<Cmd>Telescope buffers<CR>')

-- Ledger
nmap('<C-n>', ':call ledger#entry()<CR>')

-- CoC
nmap('[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
nmap(']g', '<Plug>(coc-diagnostic-next)', { silent = true })
nmap('gd', '<Plug>(coc-definition)', { silent = true })
nmap('gy', '<Plug>(coc-type-definition)', { silent = true })
nmap('gi', '<Plug>(coc-implementation)', { silent = true })
nmap('gr', '<Plug>(coc-references)', { silent = true })
nmap('<Leader>f', '<Plug>(coc-fix-current)', { silent = true })
nmap('<Leader>a', '<Plug>(coc-codeaction-line)', { silent = true })
nmap('<Leader><CR>', '<Plug>(coc-codelens-action)', { silent = true })
