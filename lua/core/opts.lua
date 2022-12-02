local M = {}

M.buffer = function(name)

    if vim.bo.filetype == "" then
        vim.bo.bufhidden = "delete"
        vim.bo.buftype = "nofile"
        vim.bo.swapfile = false
        vim.bo.buflisted = false
        vim.wo.winfixheight = true
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.bo.filetype = name
    end

end

M.disablePlugins = function()
    local plug_builtins = {
        "gzip", "zip", "tar",
        "zipPlugin", "tarPlugin",
        "getscript", "getscriptPlugin",
        "vimball", "vimballPlugin",
        "2html_plugin", "matchit",
        "matchparen", "logiPat", "spellfile_plugin",
        "rrhelper", "remote_plugins",
        "man", "shada_plugin", "syntax_completion",
        "tutor_mode_plugin", "sql_completion"
    }

    if vim.fn.isdirectory(vim.fn.argv()[1]) == 0 then
        plug_builtins = vim.tbl_extend("force", plug_builtins,
            { "netrw", "netrwPlugin", "netrwSettings" }
        )
    end

    for _, p in pairs(plug_builtins) do
        vim.g["loaded_" .. p] = 1
    end
end

M.loadOptions = function()
    local options = {
        rnu = true,
        nu = true,
        showcmd = false,
        ruler = false,
        lazyredraw = true,
        synmaxcol = 2048,
        completeopt = { "menuone", "noselect" },
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
        timeoutlen = 200,
        ttimeout = true,
        ttimeoutlen = 1,
        ttyfast = true,
        -- for telescope to be faster to open. bad idea?
        updatetime = 150,
        redrawtime = 1500,
        scrolloff = 8,
        cmdheight = 0,
        undofile = true,
        undolevels = 5000,
        writebackup = false,
        swapfile = false,
        fileformat = "unix",
        encoding = "utf-8",
        showtabline = 2,
        laststatus = 3,
        termguicolors = true,
        cursorline = true,
        cursorlineopt = "number",
        showmode = false,
        spell = false,
        spl = { "fr", "en_us" },
    }

    for k, v in pairs(options) do
        vim.opt[k] = v
    end

    vim.opt.shortmess = {
        t = true,
        A = true,
        o = true,
        O = true,
        T = true,
        f = true,
        F = true,
        s = true,
        c = true,
        W = true,
    }

    vim.opt.formatoptions = {
        ['1'] = true,
        ['2'] = true,
        q = true,
        c = true,
        r = true,
        n = true,
        t = false,
        j = true,
        l = true,
        v = true,
    }

end

M.ColorOpt = function()
    vim.o.termguicolors = true
    vim.o.background = "dark"

    vim.g.gruvbox_contrast_dark = 'dark'
    vim.cmd.colorscheme('xcodedarkhc')

end

M.config = function()
    M.disablePlugins()
    M.loadOptions()
    M.ColorOpt()

    vim.g.loaded_python_provider = false
    vim.g.python3_host_prog = vim.fn.system("which python3"):gsub("\n", "")
    vim.g.instant_username = "Cyprien"
    vim.g.explorer_is_open = false
    vim.g.rooter_silent_chdir = true
    vim.g["sneak#use_ic_scs"] = true
    vim.g.doge_mapping = "<leader>nop"

end

return M
