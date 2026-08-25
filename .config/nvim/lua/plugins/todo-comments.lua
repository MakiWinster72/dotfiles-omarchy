return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = true, -- 在符号列显示图标
    sign_priority = 8, -- 符号的优先级
    -- NOTE: 被识别为 todo 注释的关键字
    keywords = {
      FIX = {
        icon = " ", -- 符号列和搜索结果中使用的图标
        color = "error", -- 可以是十六进制颜色或命名颜色（见下方 colors）
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- 其它与 FIX 对应的关键字
        -- signs = false, -- 可以单独为某些关键字配置是否显示符号
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    gui_style = {
      fg = "NONE", -- 前景高亮组使用的 GUI 样式
      bg = "BOLD", -- 背景高亮组使用的 GUI 样式
    },
    merge_keywords = true, -- 如果为 true，自定义关键字将与默认关键字合并
    -- 高亮包含 todo 注释的整行
    -- * before: 高亮关键字前的内容（通常是注释符号）
    -- * keyword: 高亮关键字本身
    -- * after: 高亮关键字后的文本
    --  TODO:
    --  FIX:
    --  HACK:
    --  WARN:
    --  PERF:
    --  NOTE:
    --  TEST:
    highlight = {
      multiline = true, -- 支持多行 todo 注释
      multiline_pattern = "^.", -- 匹配多行 todo 注释的 Lua 模式，从关键字所在行开始
      multiline_context = 10, -- 修改行时额外重新评估的行数
      before = "", -- "fg" 或 "bg"，为空表示不高亮
      keyword = "wide", -- "fg"、"bg"、"wide"、"wide_bg"、"wide_fg" 或空。wide 与 wide_bg 同 bg，wide_fg 类似但作用于 fg
      after = "fg", -- "fg" 或 "bg"，为空表示不高亮
      pattern = [[.*<(KEYWORDS)\s*:]], -- 用于高亮的模式（vim 正则）
      comments_only = false, -- 只在注释中匹配关键字（使用 treesitter）
      max_line_len = 400, -- 忽略长度超过该值的行
      exclude = {}, -- 不进行高亮的文件类型列表
    },
    -- 命名颜色列表，会尝试从高亮组提取 guifg，找不到则使用 hex 颜色
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
      test = { "Identifier", "#FF00FF" },
    },
    search = {
      command = "rg", -- 使用 ripgrep 搜索
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- 用于匹配关键字的正则表达式，不要替换 (KEYWORDS) 占位符
      pattern = [[\b(KEYWORDS):]], -- ripgrep 正则
      -- pattern = [[\b(KEYWORDS)\b]], -- 不带冒号的匹配，可能出现误报
    },
  },
}
