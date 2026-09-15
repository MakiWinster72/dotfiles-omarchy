-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- NOTE: 开启光标十字线
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.clipboard = "unnamedplus"

-- Supermaven 使用行内灰字建议，而不是作为 nvim-cmp 的补全源。
vim.g.ai_cmp = false

-- vim.cmd.colorscheme("base16-dracula")
