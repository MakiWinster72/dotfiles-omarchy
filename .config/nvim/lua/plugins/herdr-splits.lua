return {
  {
    "lmilojevicc/herdr-splits.nvim",
    -- 仅在原生 Herdr pane 中启用；嵌套 tmux 时交给 tmux.nvim。
    cond = vim.env.HERDR_ENV == "1" and vim.env.TMUX == nil,
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<C-h>", function() require("herdr-splits").move_cursor_left() end, desc = "Navigate left" },
      { "<C-j>", function() require("herdr-splits").move_cursor_down() end, desc = "Navigate down" },
      { "<C-k>", function() require("herdr-splits").move_cursor_up() end, desc = "Navigate up" },
      { "<C-l>", function() require("herdr-splits").move_cursor_right() end, desc = "Navigate right" },
      { "<M-h>", function() require("herdr-splits").resize_left() end, desc = "Resize left" },
      { "<M-j>", function() require("herdr-splits").resize_down() end, desc = "Resize down" },
      { "<M-k>", function() require("herdr-splits").resize_up() end, desc = "Resize up" },
      { "<M-l>", function() require("herdr-splits").resize_right() end, desc = "Resize right" },
    },
  },
}
