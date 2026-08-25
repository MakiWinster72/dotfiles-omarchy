-- Guarded bootstrap for folke/lazy.nvim
-- Ensures the plugin is cloned, added to runtimepath, and that it exposes a usable `setup` function.
--
-- Place this file at: dotsfiles/nvim/lua/config/lazy.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Helper to check for fs_stat in either available luv API
local function fs_stat(path)
    if vim.loop and vim.loop.fs_stat then
        return vim.loop.fs_stat(path)
    end
    if vim.uv and vim.uv.fs_stat then
        return vim.uv.fs_stat(path)
    end
    return nil
end

if not fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local git_args = { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }

    -- Attempt a shallow clone of lazy.nvim
    local out = vim.fn.system(git_args)
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

-- Prepend lazy.nvim to rtp so `require("lazy")` resolves to the plugin we just installed
vim.opt.rtp:prepend(lazypath)

-- Protected require so startup doesn't error irrecoverably
local ok, lazy_or_err = pcall(require, "lazy")
if not ok then
    -- `lazy_or_err` contains the error message
    vim.notify("Error requiring 'lazy': " .. tostring(lazy_or_err), vim.log.levels.ERROR)
    return
end

local lazy = lazy_or_err

-- Ensure the loaded module actually exposes a `setup` function
if type(lazy.setup) ~= "function" then
    -- It is possible another module named `lazy` is on the rtp, or the checkout is corrupted.
    local msg = table.concat({
        "lazy.nvim was loaded but does not expose a `setup` function.",
        "Possible causes:",
        " - Another plugin/module named 'lazy' is shadowing folke/lazy.nvim.",
        " - The repository was cloned incorrectly or is incomplete.",
        " - You're using an incompatible version.",
        "",
        "Runtime path for lazy.nvim: " .. lazypath,
        "Inspect the contents of that directory and ensure it contains plugin code.",
    }, "\n")
    vim.notify(msg, vim.log.levels.ERROR)
    return
end

-- Call setup safely
local success, setup_err = pcall(lazy.setup, {
    spec = {
        -- add LazyVim and import its plugins
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        -- import/override with your plugins
        { import = "plugins" },
    },
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = { colorscheme = { "tokyonight", "habamax" } },
    checker = {
        enabled = true, -- check for plugin updates periodically
        notify = false, -- notify on update
    },                  -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

if not success then
    vim.notify("lazy.setup failed: " .. tostring(setup_err), vim.log.levels.ERROR)
    return
end
