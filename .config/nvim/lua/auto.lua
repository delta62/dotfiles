local api = vim.api

local function augrp(name, cmds)
    api.nvim_create_augroup(name, {})
    local pattern = cmds.pattern

    for _, value in ipairs(cmds) do
        api.nvim_create_autocmd(value[1], {
            group = name,
            pattern = value.pattern or pattern,
            command = value.command,
        })
    end
end

-- All groups: Delete trailing whitespace prior to saving
api.nvim_create_autocmd("BufWrite", {
    pattern = "*",
    command = ":%s/\\s\\+$//e"
})

augrp('asm', {
    pattern = 'asm',
    { 'FileType', command = 'setlocal syntax=nasm' },
})

augrp('coc', {
    { 'CursorHold', command = "silent call CocActionAsync('highlight')" },
})

augrp('rust', {
    pattern = 'rust',
    { 'FileType', command = "setlocal formatprg=cargo\\ fmt" },
})

augrp('quickfix', {
    { 'FileType',  pattern = 'qf', command = 'setlocal wrap' },
})

augrp('typescript', {
    pattern = 'typescript*',
    { 'FileType', command = 'setlocal cc=81 tw=80 sts=2 sw=2 fex&' },
    { 'FileType', command = 'setlocal formatprg=prettier\\ --parser\\ typescript' },
})
