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

if vim.env.TMUX then
  -- tmux：先切换 Neovim split，到边缘后切换 tmux pane。
  local function navigate(direction, tmux_direction)
    local current_window = vim.api.nvim_get_current_win()
    vim.cmd("wincmd " .. direction)
    if vim.api.nvim_get_current_win() == current_window then
      vim.fn.system({ "tmux", "select-pane", "-" .. tmux_direction })
    end
  end

  map("n", "<C-h>", function() navigate("h", "L") end, opts)
  map("n", "<C-j>", function() navigate("j", "D") end, opts)
  map("n", "<C-k>", function() navigate("k", "U") end, opts)
  map("n", "<C-l>", function() navigate("l", "R") end, opts)
elseif vim.env.HERDR_ENV == "1" then
  -- Herdr：显式覆盖 LazyVim 默认映射，避免插件映射被加载顺序覆盖。
  map("n", "<C-h>", function() require("herdr-splits").move_cursor_left() end, opts)
  map("n", "<C-j>", function() require("herdr-splits").move_cursor_down() end, opts)
  map("n", "<C-k>", function() require("herdr-splits").move_cursor_up() end, opts)
  map("n", "<C-l>", function() require("herdr-splits").move_cursor_right() end, opts)
end
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
