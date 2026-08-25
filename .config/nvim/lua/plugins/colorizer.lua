return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    vim.opt.termguicolors = true

    require("colorizer").setup({
      "*",
      css = { css = true },
      scss = { css = true },
      sass = { css = true },
      less = { css = true },
      html = { css = true },
      javascript = { css = true },
      typescript = { css = true },
      javascriptreact = { css = true },
      typescriptreact = { css = true },
    })
  end,
}
