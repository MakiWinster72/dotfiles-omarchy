return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      win = {
        position = "float",
        border = "rounded",
        width = 0.85,
        height = 0.75,
        title = " Terminal ",
        title_pos = "center",
        wo = {
          winblend = 3,
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
        },
      },
    },
  },

  keys = {
    {
      "<leader>ft",
      function()
        Snacks.terminal.toggle()
      end,
      desc = "Toggle floating terminal",
      mode = { "n", "t" },
    },
  },

  init = function()
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*",
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.cursorline = false

        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
          buffer = true,
          desc = "Exit terminal mode",
        })
      end,
    })
  end,
}
