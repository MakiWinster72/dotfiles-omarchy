-- 此文件只保留个人快捷键覆盖。替换默认快捷键前，请先将其解绑。

-- 查看当前生效的快捷键及说明：
--   omarchy menu keybindings --print

-- 如需禁用所有 Omarchy 默认快捷键，请在
-- ~/.config/hypr/hyprland.lua 的 require("default.hypr.omarchy") 之前设置
-- 以下选项，然后只在本文件中添加需要的快捷键：
--   omarchy_default_bindings = false

-- 如需禁用所有预装应用和网页应用快捷键，请设置：
--   omarchy_preinstalled_bindings = false

-- 新增快捷键示例：
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

hl.unbind("SUPER + SPACE")
o.bind("ALT + SPACE", "Omarchy menu", "omarchy-menu toggle")

-- Niri 风格的应用快捷键。
-- SUPER + T 原功能：切换窗口浮动/平铺。
-- SUPER + O 原功能：弹出并固定窗口。
-- SUPER + W 原功能：关闭窗口。
-- SUPER + SHIFT + RETURN 原功能：打开浏览器。
-- SUPER + X 原功能：通用剪切。
-- SUPER + G 原功能：切换窗口分组。
-- SUPER + SHIFT + G 原功能：打开 Signal。
-- SUPER + TAB 原功能：切换到下一个工作区。
-- SUPER + SHIFT + TAB 原功能：切换到上一个工作区。
-- SUPER + SHIFT + A 原功能：打开 ChatGPT。
-- SUPER + SHIFT + D 原功能：打开 Docker。
-- SUPER + SHIFT + ALT + A 原功能：打开 Grok 网页应用。
-- SUPER + F 原功能：真正全屏。
-- SUPER + SHIFT + F 原功能：打开文件管理器。
hl.unbind("SUPER + T")
hl.unbind("SUPER + O")
hl.unbind("SUPER + W")
hl.unbind("SUPER + SHIFT + RETURN")
hl.unbind("SUPER + CTRL + V")
hl.unbind("SUPER + X")
hl.unbind("SUPER + G")
hl.unbind("SUPER + SHIFT + G")
hl.unbind("SUPER + TAB")
hl.unbind("SUPER + SHIFT + TAB")
hl.unbind("SUPER + SHIFT + A")
hl.unbind("SUPER + SHIFT + D")
hl.unbind("SUPER + SHIFT + ALT + A")
hl.unbind("SUPER + F")
hl.unbind("SUPER + SHIFT + F")

o.bind("SUPER + T", "Terminal", { omarchy = "terminal" })
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())
o.bind("SUPER + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + E", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + O", "Obsidian", { launch = "obsidian", focus = "^obsidian$" })
o.bind("SUPER + Y", "Telegram", { launch = "telegram-desktop" })
o.bind("SUPER + Z", "Clash Verge", { launch = "clash-verge", focus = "^clash-verge$" })
o.bind("SUPER + ALT + L", "Lock system", "omarchy-system-lock")
o.bind("SUPER + M", "切换工作区布局", "omarchy-hyprland-workspace-layout-toggle")
o.bind("SUPER + F", "最大化窗口", hl.dsp.window.fullscreen({ mode = "maximized" }))
o.bind("SUPER + SHIFT + F", "全屏窗口", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
o.bind("SUPER + TAB", "切换到上一个工作区", hl.dsp.focus({ workspace = "e-1" }))
o.bind("SUPER + SHIFT + TAB", "工作区总览", "pkill -SIGUSR1 hyprexpose")

-- 滚动布局：在相邻列之间吸收或移出当前窗口。
o.bind("SUPER + BRACKETLEFT", "向左吸收/移出窗口", hl.dsp.layout("consume_or_expel prev"))
o.bind("SUPER + BRACKETRIGHT", "向右吸收/移出窗口", hl.dsp.layout("consume_or_expel next"))

o.bind("SUPER + X", "剪贴板管理器", "omarchy-shell shell toggle omarchy.clipboard")
o.bind("SUPER + SHIFT + V", "剪贴板管理器", "omarchy-shell shell toggle omarchy.clipboard")
o.bind("SUPER + G", "切换浮动/平铺", hl.dsp.window.float({ action = "toggle" }))
o.bind("SUPER + SHIFT + G", "切换浮动/平铺窗口焦点", function()
  local window = hl.get_active_window()
  if not window then return end

  if window.floating then
    hl.dispatch(hl.dsp.window.cycle_next({ tiled = true }))
  else
    hl.dispatch(hl.dsp.window.cycle_next({ floating = true }))
  end
end)

-- Niri 风格的焦点快捷键。
-- 以下按键原功能依次为：Scratchpad、窗口分割、快捷键列表、工作区布局、
-- 交换窗口，以及音频、显示器、硬件、Herdr 快捷键和锁屏面板。
hl.unbind("SUPER + S")
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
hl.unbind("SUPER + SHIFT + LEFT")
hl.unbind("SUPER + SHIFT + RIGHT")
hl.unbind("SUPER + SHIFT + UP")
hl.unbind("SUPER + SHIFT + DOWN")
hl.unbind("SUPER + CTRL + A")
hl.unbind("SUPER + CTRL + D")
hl.unbind("SUPER + CTRL + H")
hl.unbind("SUPER + CTRL + K")
hl.unbind("SUPER + CTRL + L")

-- 聚焦相邻窗口；SUPER + 方向键保留 Omarchy 已有的相同功能。
o.bind("SUPER + H", "聚焦左侧窗口", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + L", "聚焦右侧窗口", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + K", "聚焦上方窗口", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + J", "聚焦下方窗口", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + A", "聚焦左侧窗口", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + D", "聚焦右侧窗口", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + W", "聚焦上方窗口", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + S", "聚焦下方窗口", hl.dsp.focus({ direction = "d" }))

-- 使用 Vim 方向键移动窗口：平铺窗口交换位置，浮动窗口每次移动 50 像素。
local function move_or_swap_window(direction, x, y)
  return function()
    local window = hl.get_active_window()
    if not window then return end

    if window.floating then
      hl.dispatch(hl.dsp.window.move({ x = x, y = y, relative = true }))
    else
      hl.dispatch(hl.dsp.window.swap({ direction = direction }))
    end
  end
end

o.bind("SUPER + SHIFT + H", "向左移动窗口", move_or_swap_window("l", -50, 0), { repeating = true })
o.bind("SUPER + SHIFT + A", "向左移动窗口", move_or_swap_window("l", -50, 0), { repeating = true })
o.bind("SUPER + SHIFT + L", "向右移动窗口", move_or_swap_window("r", 50, 0), { repeating = true })
o.bind("SUPER + SHIFT + D", "向右移动窗口", move_or_swap_window("r", 50, 0), { repeating = true })
o.bind("SUPER + SHIFT + K", "向上移动窗口", move_or_swap_window("u", 0, -50), { repeating = true })
o.bind("SUPER + SHIFT + J", "向下移动窗口", move_or_swap_window("d", 0, 50), { repeating = true })

-- 将窗口移动到相邻工作区，并跟随窗口切换过去。
o.bind("SUPER + SHIFT + I", "移动窗口到上一个工作区", hl.dsp.window.move({ workspace = "e-1" }))
o.bind("SUPER + SHIFT + U", "移动窗口到下一个工作区", hl.dsp.window.move({ workspace = "e+1" }))

-- 居中窗口：浮动窗口居中到屏幕；滚动布局将当前列居中。
o.bind("SUPER + I", "居中窗口/滚动列", function()
  local window = hl.get_active_window()
  if not window then return end

  if window.floating then
    hl.dispatch(hl.dsp.window.center())
    return
  end

  local workspace = hl.get_active_workspace()
  if workspace and workspace.tiled_layout == "scrolling" then
    hl.dispatch(hl.dsp.layout("center"))
  end
end)

-- 聚焦上一个或下一个工作区。
o.bind("SUPER + Page_Up", "聚焦上一个工作区", hl.dsp.focus({ workspace = "e-1" }))
o.bind("SUPER + U", "聚焦下一个工作区", hl.dsp.focus({ workspace = "e+1" }))
o.bind("SUPER + Page_Down", "聚焦下一个工作区", hl.dsp.focus({ workspace = "e+1" }))

-- 聚焦相邻显示器。
o.bind("SUPER + SHIFT + LEFT", "聚焦左侧显示器", hl.dsp.focus({ monitor = "l" }))
o.bind("SUPER + SHIFT + RIGHT", "聚焦右侧显示器", hl.dsp.focus({ monitor = "r" }))
o.bind("SUPER + SHIFT + UP", "聚焦上方显示器", hl.dsp.focus({ monitor = "u" }))
o.bind("SUPER + SHIFT + DOWN", "聚焦下方显示器", hl.dsp.focus({ monitor = "d" }))
o.bind("SUPER + CTRL + A", "聚焦左侧显示器", hl.dsp.focus({ monitor = "l" }))
o.bind("SUPER + CTRL + H", "聚焦左侧显示器", hl.dsp.focus({ monitor = "l" }))
o.bind("SUPER + CTRL + D", "聚焦右侧显示器", hl.dsp.focus({ monitor = "r" }))
o.bind("SUPER + CTRL + L", "聚焦右侧显示器", hl.dsp.focus({ monitor = "r" }))
o.bind("SUPER + CTRL + K", "聚焦上方显示器", hl.dsp.focus({ monitor = "u" }))
o.bind("SUPER + CTRL + J", "聚焦下方显示器", hl.dsp.focus({ monitor = "d" }))

-- 将当前窗口移动到相邻显示器，并跟随窗口切换过去。
o.bind("SUPER + SHIFT + CTRL + H", "移动窗口到左侧显示器", hl.dsp.window.move({ monitor = "l" }))
o.bind("SUPER + SHIFT + CTRL + L", "移动窗口到右侧显示器", hl.dsp.window.move({ monitor = "r" }))
o.bind("SUPER + SHIFT + CTRL + K", "移动窗口到上方显示器", hl.dsp.window.move({ monitor = "u" }))
o.bind("SUPER + SHIFT + CTRL + J", "移动窗口到下方显示器", hl.dsp.window.move({ monitor = "d" }))

-- 按住 SUPER 转动键盘音量滚轮，调节屏幕亮度。
o.bind("SUPER + XF86AudioRaiseVolume", "提高屏幕亮度", "omarchy-brightness-display +10%", { locked = true, repeating = true })
o.bind("SUPER + XF86AudioLowerVolume", "降低屏幕亮度", "omarchy-brightness-display 10%-", { locked = true, repeating = true })

-- 原 Niri 配置中的媒体键焦点备用方案。
o.bind("CTRL + XF86AudioRaiseVolume", "聚焦左侧窗口", hl.dsp.focus({ direction = "l" }))
o.bind("CTRL + XF86AudioLowerVolume", "聚焦右侧窗口", hl.dsp.focus({ direction = "r" }))
o.bind("CTRL + SHIFT + XF86AudioRaiseVolume", "聚焦上一个工作区", hl.dsp.focus({ workspace = "e-1" }))
o.bind("CTRL + SHIFT + XF86AudioLowerVolume", "聚焦下一个工作区", hl.dsp.focus({ workspace = "e+1" }))

-- 修改现有快捷键时，请先解绑，再重新绑定。
-- 此示例将 SUPER+SPACE 从启动器改为 Omarchy 根菜单。
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- 只禁用默认快捷键，不设置替代快捷键：
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys 示例：
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")
