local M = {}

local format = require('plugins.format').get
local colors = u.colors.get()
local icons = require('utils.icons')

M.filter = function()
    return vim.bo.modifiable and not u.ft.is_disabled('lualine')
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
        return not vim.tbl_isempty(vim.lsp.get_active_clients({ bufnr = 0 }))
    end,
    icons.lsp,
    M.filter
)

M.format = inject_toggle(
    function()
        return u.fun.capabilities('format', 0)
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
        return u.icons.progress[
            math.ceil(vim.fn.line '.' / vim.fn.line '$' * #u.icons.progress)
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
        u.fun.toggle("DiffviewOpen", "DiffviewClose")
    end
}

M.spaces = {
    function()
        local size = nvim.buf_get_option(0, "shiftwidth")
        if size == 0 then
            size = nvim.buf_get_option(0, "tabstop")
        end
        return string.format("%s %s", u.icons.spaces, size)
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

M.searchcount = {
    function()
        local search = vim.fn.searchcount({ maxcount = 0 })

        if vim.g.cool_is_searching == 1 then
            return search.current .. "/" .. search.total
        end

        return ""
    end,
    cond = M.filter
}

return M
