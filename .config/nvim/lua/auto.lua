local api = vim.api

-- All groups: Delete trailing whitespace prior to saving
api.nvim_create_autocmd("BufWrite", {
    pattern = "*",
    command = ":%s/\\s\\+$//e"
})

api.nvim_create_augroup('coc', {})
api.nvim_create_autocmd('CursorHold', {
    group = 'coc',
    command = "silent call CocActionAsync('highlight')"
})

api.nvim_create_augroup('asm', {})
api.nvim_create_autocmd('FileType', {
    group = 'asm',
    pattern = 'asm',
    command = 'setlocal syntax=nasm',
})

api.nvim_create_augroup('quickfix', {})
api.nvim_create_autocmd('FileType', {
    group = 'quickfix',
    pattern = 'qf',
    command = 'setlocal wrap',
})

api.nvim_create_augroup('rust', {})
api.nvim_create_autocmd('FileType', {
    group = 'rust',
    pattern = "rust",
    command = "setlocal formatprg=cargo\\ fmt",
})

api.nvim_create_augroup('typescript', {})
api.nvim_create_autocmd('FileType', {
    group = 'typescript',
    pattern = 'typescript*',
    command = 'setlocal cc=81 tw=80 sts=2 sw=2 fex&',
})
api.nvim_create_autocmd('FileType', {
    group = 'typescript',
    pattern = 'typescript*',
    command = 'setlocal formatprg=prettier\\ --parser\\ typescript',
})
