-- NOTE: == insert 模式隐藏十字线，normal 模式显示 ==
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    vim.opt.cursorline = false
    vim.opt.cursorcolumn = false
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    vim.opt.cursorline = true
    vim.opt.cursorcolumn = true
  end,
})

-- local function set_transparency()
--   vim.cmd([[
--     hi Normal       guibg=NONE ctermbg=NONE
--     hi NormalNC     guibg=NONE ctermbg=NONE
--     hi SignColumn   guibg=NONE ctermbg=NONE
--     hi StatusLine   guibg=NONE ctermbg=NONE
--     hi StatusLineNC guibg=NONE ctermbg=NONE
--     hi VertSplit    guibg=NONE ctermbg=NONE
--     hi Pmenu        guibg=NONE ctermbg=NONE
--     hi PmenuSel     guibg=NONE ctermbg=NONE
--     hi EndOfBuffer  guibg=NONE ctermbg=NONE
--     hi NormalFloat         guibg=NONE ctermbg=NONE
--     hi FloatBorder         guibg=NONE ctermbg=NONE
--     hi NeoTreeNormal       guibg=NONE ctermbg=NONE
--     hi NeoTreeNormalNC     guibg=NONE ctermbg=NONE
--     hi BufferLineFill      guibg=NONE ctermbg=NONE
--     hi StatusLine          guibg=NONE ctermbg=NONE
--     hi TabLine             guibg=NONE ctermbg=NONE
--     hi TabLineFill         guibg=NONE ctermbg=NONE
--     hi TabLineSel          guibg=NONE ctermbg=NONE
--   ]])
-- end
--
-- set_transparency()

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*",
--   callback = set_transparency,
-- })
