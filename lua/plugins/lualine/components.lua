local M = {}

local format = require('plugins.format').get
local colors = u.colors.get()
local icons = require('utils.icons')
local harpoon = require("harpoon")
local themes = require('plugins.lualine.themes')
local fun = require("utils.fun")

M.filter = function()
    return vim.bo.modifiable and not u.ft.is_disabled('lualine')
end

M.test = function()
    return not M.filter()
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
        return fun.check_formatting_capability()
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

M.harpoon = {
    function()
        local current = vim.fn.expand("%:t")
        local marks = harpoon.get_mark_config().marks
        local output = ""


        vim.api.nvim_set_hl(0, "HarpoonCurrent", { fg = colors.magenta, bg = themes[vim.g.colors_name].normal.c.bg })
        vim.api.nvim_set_hl(0, "HarpoonNormal", { fg = colors.grey, bg = themes[vim.g.colors_name].normal.c.bg })

        for i in pairs(marks) do
            local bname = vim.fs.basename(marks[i].filename)
            if bname == current then
                output = output .. " %#HarpoonCurrent#" .. icons.modified
            else
                output = output .. " %#HarpoonNormal#" .. icons.modified
            end
        end

        if M.filter() then
            return output
        else
            return ""
        end
    end
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
    -- separator = { right = '' },
    -- separator = { right = "" },
    padding = { right = 1 },

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
    cond = M.filter,
    separator = { right = "" },
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

local state

M.runcode = {
    function()
        if vim.g.runcode_executing then
            state = state + 1

            if not u.icons.progress[state] then
                state = 1
            end

            return u.icons.progress[state]
        else
            state = 0
            return ""
        end
    end,
    padding = {
        left = 2,
    }
}

return M
