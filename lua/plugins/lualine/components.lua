local M = {}

local format = require('plugins.format').get()
local colors = vim.colors.get()

M.filter = function()
    return not vim.tbl_contains(
        { 'harpoon', 'spectre_panel', 'lspsagafinder' },
        vim.bo.filetype) and vim.bo.modifiable and not vim.bo.readonly
        and vim.fn.bufname() ~= ""
end

local function inject_toggle(func, icon, cond)

    if not cond then
        return { on = { func, "", cond }, off = { func, "", cond } }
    end

    return {
        on = {
            function()
                return func() and icon or ""
            end,
            cond = cond,
            color = { fg = colors.green }
        },
        off = {
            function()
                return not func() and icon or ""
            end,
            cond = cond,
            color = { fg = colors.red }
        }
    }
end

M.lsp = inject_toggle(
    function()
        return #vim.lsp.buf_get_clients() > 0
    end,
    "",
    M.filter
)

M.format = inject_toggle(
    function()
        return vim.func.capabilities('format', 0)
            or vim.tbl_contains(format, vim.bo.filetype)
    end,
    "⍟",
    M.filter
)

M.ts = inject_toggle(
    function()
        return require "nvim-treesitter.parsers".get_parser(
            vim.fn.bufnr('%'), vim.bo.filetype
        ) ~= nil
    end,
    "",
    M.filter
)

M.mode = {
    function()
        return " "
    end,
    separator = {
        left = '',
        right = ''
    },
    padding = 1
}

M.progression = {
    function()
        local chrs = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇" }

        return chrs[
            math.ceil(vim.fn.line '.' / vim.fn.line '$' * #chrs)
            ]
    end,
    cond = M.filter,
}

M.filename = {
    'filename',
    symbols = {
        modified = " ●"
    },
    cond = M.filter,
}

M.diff = {
    'diff',
    symbols = {
        added = "",
        modified = "",
        removed = ""
    },
    cond = function()
        return not vim.g.DiffviewOpen
    end,
    on_click = function()
        vim.func.toggle("DiffviewOpen", "DiffviewClose")
    end
}

M.spaces = {
    function()
        local size = vim.api.nvim_buf_get_option(0, "shiftwidth")
        if size == 0 then
            size = vim.api.nvim_buf_get_option(0, "tabstop")
        end
        return "⇥ " .. size
    end,
    color = { fg = colors.blue },
    cond = M.filter,
}

M.filetype = {
    'filetype',
    icon_only = true,
    separator = { right = '' },

    fmt = function(str)
        local names = {
            TelescopePrompt = "",
            NvimTree = "",
            DiffviewFiles = "署"
        }

        for k, v in pairs(names) do
            if vim.bo.filetype == k then
                return v
            end
        end

        return str
    end

}

M.branch = {
    'branch',
    padding = {
        left = 2,
        right = 1
    },
    cond = M.filter
}

return M
