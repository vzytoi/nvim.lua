local M = {}
local utils = require("utils")

function M.setBufferOpts()
    vim.bo.bufhidden = "delete"
    vim.bo.buftype = "nofile"
    vim.bo.swapfile = false
    vim.bo.buflisted = false
    vim.wo.winfixheight = true
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.bo.filetype = "runcode"
end

function M.disablePlugins()
    local plug_buitlins = {
        "gzip",
        "zip",
        "zipPlugin",
        "tar",
        "tarPlugins",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "matchit",
        "matchparen",
        "logiPat",
        "rrhelper",
        "remote_plugins",
        "man",
        "shada_plugin",
        "tutor_mode_plugin"
    }

    if vim.fn.isdirectory(vim.fn.argv()[1]) == 0 then
        plug_buitlins = utils.mergeTables(plug_buitlins, {"netrw", "netrwPlugin", "netrwSettings"})
    end

    for _, p in pairs(plug_buitlins) do
        vim.g["loaded_" .. p] = 1
    end
end

function M.loadOptions()
    local options = {
        rnu = true,
        nu = true,
        showcmd = false,
        ruler = false,
        lazyredraw = true,
        synmaxcol = 2048,
        completeopt = {"menuone", "noselect"},
        expandtab = true,
        autoindent = true,
        smartindent = true,
        cindent = true,
        shiftwidth = 4,
        softtabstop = 4,
        tabstop = 8,
        wrap = false,
        ignorecase = true,
        smartcase = true,
        mouse = "a",
        splitright = true,
        splitbelow = true,
        timeout = true,
        timeoutlen = 250,
        ttimeout = true,
        ttimeoutlen = 10,
        updatetime = 300,
        redrawtime = 1500,
        scrolloff = 8,
        undofile = true,
        undolevels = 10000,
        writebackup = false,
        swapfile = false,
        fileformat = "unix",
        spell = false,
        spl = {"fr", "en_us"},
        encoding = "utf-8",
        laststatus = 3
    }

    for k, v in pairs(options) do
        vim.opt[k] = v
    end
end

function M.ColorOpt()
    vim.o.termguicolors = true
    vim.o.background = "dark"

    vim.cmd("colorscheme gruvbox")
end

function M.config()
    M.disablePlugins()
    M.loadOptions()
    M.ColorOpt()

    vim.g["loaded_python_provider"] = false
    vim.g["python3_host_prog"] = vim.fn.system("which python"):gsub("\n", "")
    vim.g.explorer_is_open = false
    vim.g.rooter_silent_chdir = true
    vim.g["sneak#use_ic_scs"] = true
end

return M
