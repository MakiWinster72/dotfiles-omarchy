-- 桌面启动器可能漏传 XDG_RUNTIME_DIR；wl-copy 需要它来连接 Wayland socket。
-- 不依赖 vim.g.neovide，因为 Neovide 可能在加载 init.lua 后才设置该变量。
if vim.env.WAYLAND_DISPLAY and not vim.env.XDG_RUNTIME_DIR then
    vim.env.XDG_RUNTIME_DIR = "/run/user/" .. vim.uv.os_get_passwd().uid
end

-- Neovide 固定使用 Wayland 后端，避免启动时 provider 自动探测结果被缓存。
if vim.env.WAYLAND_DISPLAY then
    vim.g.clipboard = "wl-copy"
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- NOTE: 通用 GUI 字体
vim.o.guifont = "0xProto Nerd Font Mono:h12"

-- 普通复制/粘贴默认使用系统剪贴板；Neovide 在 Wayland 下会通过 wl-clipboard 写入它。
vim.opt.clipboard = "unnamedplus"

-- NOTE: SSH 下使用 OSC52 剪贴板
if vim.env.SSH_TTY then
    local osc52 = require("vim.ui.clipboard.osc52")

    vim.g.clipboard = {
        name = "OSC52",
        copy = {
            ["+"] = osc52.copy("+"),
            ["*"] = osc52.copy("*"),
        },
        paste = {
            ["+"] = function()
                return vim.fn.getreg("+")
            end,
            ["*"] = function()
                return vim.fn.getreg("*")
            end,
        },
    }
end

-- NOTE: Neovide

if vim.g.neovide then
    -- 窗口透明度（透明度 (opacity)）
    vim.g.neovide_opacity = 0.75
    vim.g.neovide_normal_opacity = 0.75

    -- 浮动窗口模糊（浮动模糊 (floating_blur_amount)）
    vim.g.neovide_floating_blur_amount_x = 6.0
    vim.g.neovide_floating_blur_amount_y = 6.0

    -- 浮动阴影与圆角（浮动阴影 (floating_shadow) / 圆角 (floating_corner_radius)）
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 10
    vim.g.neovide_floating_corner_radius = 0.0

    -- 光标特效（光标特效 (cursor_vfx_mode)）与粒子参数
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    -- 可选: "railgun","torpedo","pixiedust","sonicboom","ripple","wireframe",""
    vim.g.neovide_cursor_vfx_particle_lifetime = 2.8 -- 粒子存活时长（秒）
    vim.g.neovide_cursor_vfx_particle_highlight_lifetime = 1.8 -- 高亮粒子存活时长（针对部分模式）
    vim.g.neovide_cursor_vfx_particle_density = 8.0 -- 粒子密度（每行移动粒子数，默认约 0.7；8.0 较密）
    vim.g.neovide_cursor_vfx_particle_speed = 10.0 -- 粒子速度（像素/秒）
    vim.g.neovide_cursor_vfx_particle_phase = 1.5 -- 仅 railgun 有效（粒子相互独立程度）
    vim.g.neovide_cursor_vfx_particle_curl = 1.0 -- 仅 railgun 有效（旋转/卷曲程度）
    vim.g.neovide_cursor_vfx_opacity = 200.0 -- 粒子不透明度（数值越大越不透明）

    -- 光标动画（光标动画时长 (cursor_animation_length) / 平滑闪烁）
    vim.g.neovide_cursor_animation_length = 0.150
    vim.g.neovide_cursor_short_animation_length = 0.04
    vim.g.neovide_cursor_trail_size = 1.0
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
    vim.g.neovide_cursor_unfocused_outline_width = 0.125
    vim.g.neovide_cursor_smooth_blink = false

    -- 滚动/位置动画（滚动动画时长 (scroll_animation_length) / 位置动画 (position_animation_length)）
    vim.g.neovide_scroll_animation_length = 0.3
    vim.g.neovide_scroll_animation_far_lines = 1
    vim.g.neovide_position_animation_length = 0.15

    -- 进度条（Nightly 功能）
    vim.g.neovide_progress_bar_enabled = true
    vim.g.neovide_progress_bar_height = 5.0
    vim.g.neovide_progress_bar_animation_speed = 200.0
    vim.g.neovide_progress_bar_hide_delay = 0.2

    -- 刷新率（刷新率 (refresh_rate) / 空闲刷新率 (refresh_rate_idle)）
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 5
    vim.g.neovide_no_idle = false

    -- 主题同步（主题 (theme)）
    vim.g.neovide_theme = "auto" -- "auto" | "light" | "dark" | "<bg_color>"

    -- 默认缩放因子（缩放因子 (scale_factor)）
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor or 1.0

    -- 缩放辅助函数：限制最小值与步长为 0.1
    local function set_neovide_scale(delta)
        local cur = tonumber(vim.g.neovide_scale_factor) or 1.0
        cur = math.floor((math.max(0.5, cur + delta) * 10) + 0.5) / 10 -- 保留一位小数，最小 0.5
        vim.g.neovide_scale_factor = cur
        -- 可选：在状态栏显示当前缩放（如使用 lualine 可在配置中显示 vim.g.neovide_scale_factor）
    end

    -- 快捷键：放大 (Ctrl+=)、缩小 (Ctrl+-)、重置 (Ctrl+0)
    vim.keymap.set("n", "<C-=>", function()
        set_neovide_scale(0.1)
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-->", function()
        set_neovide_scale(-0.1)
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-0>", function()
        vim.g.neovide_scale_factor = 1.0
    end, { noremap = true, silent = true })

    -- IME 输入法控制（仅在需要时启用 IME (input_ime)）
    vim.g.neovide_input_ime = true
    local function _neovide_set_ime(event)
        if event:match("Enter$") then
            vim.g.neovide_input_ime = true
        else
            vim.g.neovide_input_ime = false
        end
    end
    local ime_input =
        vim.api.nvim_create_augroup("neovide_ime_input", { clear = true })
    vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
        group = ime_input,
        pattern = "*",
        callback = function(args)
            _neovide_set_ime(args.event)
        end,
    })
    vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
        group = ime_input,
        pattern = "[/\\?]",
        callback = function(args)
            _neovide_set_ime(args.event)
        end,
    })
end
