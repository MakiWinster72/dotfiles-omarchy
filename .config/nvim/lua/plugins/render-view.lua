-- -- ~/.config/nvim/lua/plugins/render-markdown.lua
return {
  "MeanderingProgrammer/render-markdown.nvim",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-mini/mini.nvim",
    -- "nvim-mini/mini.icons",  -- 如果你用独立 mini 插件
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- open_cmd = "tabedit"  -- 打开预览的方式
  },
}
