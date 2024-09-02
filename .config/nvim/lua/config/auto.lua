local function augrp(name, cmds)
  vim.api.nvim_create_augroup(name, {})
  local pattern = cmds.pattern

  for _, value in ipairs(cmds) do
    vim.api.nvim_create_autocmd(value[1], {
      group = name,
      pattern = value.pattern or pattern,
      command = value.command,
    })
  end
end

-- All groups: Delete trailing whitespace prior to saving
vim.api.nvim_create_autocmd("BufWrite", {
  pattern = "*",
  command = ":%s/\\s\\+$//e"
})

-- All groups: Set light/dark mode when USR1 signal is received
vim.api.nvim_create_autocmd("Signal", {
  pattern = "*",
  callback = function(e)
    local proc = io.popen("/home/sam/scripts/dark_mode.sh get", "r")
    local mode = proc:read("l")
    vim.api.nvim_set_option_value("background", mode, { scope = "global" })
  end,
})

augrp('coc', {
  { 'CursorHold', command = "silent call CocActionAsync('highlight')" },
})

augrp('lua', {
  pattern = 'lua',
  { 'FileType', command = 'setlocal sw=2 sts=2' },
})

augrp('markdown', {
  pattern = 'markdown',
  { 'FileType', command = 'setlocal tw=80 cc=+1' },
})

augrp('nvim_tree', {
  pattern = 'NvimTree',
  { 'FileType', command = "setlocal nospell" },
})

augrp('quickfix', {
  { 'FileType',  pattern = 'qf', command = 'setlocal wrap' },
})

augrp('pug', {
  { 'FileType', pattern = 'pug', command = 'setlocal sw=2 sts=2' },
})

augrp('ruby', {
  { 'FileType', pattern = 'Guardfile', command = 'setlocal syntax ruby' }
})

augrp('rust', {
  pattern = 'rust',
  { 'FileType', command = "setlocal formatprg=cargo\\ fmt" },
})

augrp('typescript', {
  pattern = 'typescript*',
  { 'FileType', command = 'setlocal cc=81 tw=80 sts=2 sw=2 fex&' },
  { 'FileType', command = 'setlocal formatprg=prettier\\ --parser\\ typescript' },
})

augrp('javascript', {
  pattern = 'javascript',
  { 'FileType', command = 'setlocal cc=81 tw=80 sts=2 sw=2 fex&' },
  { 'FileType', command = 'setlocal formatprg=prettier' },
})

augrp('ledger', {
  pattern = 'ledger',
  { 'FileType', command = 'setlocal formatprg=ledgerfmt' },
})

augrp('grammar', {
  pattern = '*.grammar',
  { 'BufEnter', command = 'setlocal filetype=grammar' }
})
