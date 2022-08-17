local M = {}

local format = require('plugins.format').get
local colors = vim.colors.get()
local icons = require('utils.icons')

M.filter = function()
    return not vim.ft.is_disabled('lualine')
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
        return #vim.lsp.get_active_clients({ bufnr = 0 }) > 0
    end,
    icons.lsp,
    M.filter
)

M.format = inject_toggle(
    function()
        return vim.func.capabilities('format', 0)
            or format(vim.bo.filetype)
    end,
    icons.format,
    M.filter
)

M.ts = inject_toggle(
    function()
        return require "nvim-treesitter.parsers".get_parser(
            vim.fn.bufnr('%'), vim.bo.filetype
        ) ~= nil
    end,
    icons.treesitter,
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
        return vim.icons.progress[
            math.ceil(vim.fn.line '.' / vim.fn.line '$' * #vim.icons.progress)
            ]
    end,
    cond = M.filter,
}

M.filename = {
    'filename',
    symbols = {
        modified = " " .. icons.modified
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
        return not vim.g.DiffviewOpen and M.filter()
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
        return string.format("%s %s", vim.icons.spaces, size)
    end,
    color = { fg = colors.blue },
    cond = M.filter,
}

M.filetype = {
    'filetype',
    icon_only = true,
    separator = { right = '' },

    fmt = function(str)
        if vim.tbl_contains(vim.tbl_keys(icons), vim.bo.filetype) then
            return icons[vim.bo.filetype]
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
