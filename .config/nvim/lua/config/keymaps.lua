-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- 引入 toggleterm
-- ~/.config/nvim/lua/config/keymaps.lua

-- vim.keymap.set("v", "<C-c>", '"+y')

-- NOTE: 快速输入两个j, insert -> normal
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false })

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
-- 启动/继续
map("n", "<F5>", require("dap").continue, opts)
-- 暂停/中断
map("n", "<F6>", require("dap").pause, opts)
-- 停止调试
map("n", "<F7>", require("dap").terminate, opts)
-- 重启
map("n", "<F8>", require("dap").restart, opts)
-- 设置断点
map("n", "<F9>", require("dap").toggle_breakpoint, opts)
-- 条件断点
map("n", "<leader>b", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, opts)
-- 单步跳入
map("n", "<F10>", require("dap").step_into, opts)
-- 单步跳出
map("n", "<F11>", require("dap").step_out, opts)
-- 单步跳过
map("n", "<F12>", require("dap").step_over, opts)
