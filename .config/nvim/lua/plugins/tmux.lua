return {
  {
    "aserowy/tmux.nvim",
    -- tmux 可能从 Herdr 继承 HERDR_ENV；进入 tmux 后应优先使用 tmux 导航。
    cond = vim.env.TMUX ~= nil,
    keys = {
      { "<C-h>", function() require("tmux").move_left() end, desc = "Navigate left" },
      { "<C-j>", function() require("tmux").move_bottom() end, desc = "Navigate down" },
      { "<C-k>", function() require("tmux").move_top() end, desc = "Navigate up" },
      { "<C-l>", function() require("tmux").move_right() end, desc = "Navigate right" },
    },
    opts = {
      -- Neovide 不在 tmux pane 中；否则插件会把 g:clipboard 覆盖为 tmux provider。
      copy_sync = {
        enable = false,
      },
      navigation = {
        enable_default_keybindings = true,
      },
      resize = {
        enable_default_keybindings = true,
      },
    },
  },
}
