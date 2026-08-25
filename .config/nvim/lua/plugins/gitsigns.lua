return {
    "lewis6991/gitsigns.nvim",
    opts = {
        current_line_blame = true,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol",
            delay = 100,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%R> • <summary>",
    },
    keys = {
        {
            "<leader>gb",
            function()
                require("gitsigns").toggle_current_line_blame()
            end,
            desc = "Toggle current line Git blame",
        },
    },
}
