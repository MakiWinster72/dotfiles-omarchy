return {
  {
    "aserowy/tmux.nvim",
    cond = vim.env.HERDR_ENV ~= "1",
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
