return {
  "atiladefreitas/bloocky",
  config = function()
    require("bloocky").setup({
      default_view = "week",
      week_start = "monday",

      hours = {
        start = 8,
        ["end"] = 22,
      },

      window = {
        mode = "float",
        border = "rounded",
        width = {
          month = 0.8,
          week = 0.7,
          day = 46,
        },
      },

      keymaps = {
        toggle = "<leader>tb",
        toggle_sidebar = "<leader>tB",
      },
    })
  end,
}
