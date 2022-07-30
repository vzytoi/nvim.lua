local M = {}

local fts = {
    "TelescopePrompt",
    "NvimTree",
    "RunCode",
    "DiffviewFiles",
    "help",
    "qf"
}

M.mode = {
    function()
        return " "
    end,
    separator = {
        left = '',
        right = ''
    },
    padding = 2
}

M.progression = {
    function()
        local chrs = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇" }

        return chrs[
            math.ceil(vim.fn.line '.' / vim.fn.line '$' * #chrs)
            ]
    end,
    fmt = function(str)
        for _, v in ipairs(fts) do
            if vim.bo.filetype == v then
                return ""
            end
        end

        return str
    end,
    color = { fg = '#808080' }
}

M.lsp = {
    function()
        local clients = vim.lsp.buf_get_clients()
        local names = {}

        for _, client in pairs(clients) do
            if not vim.g.fn.has(names, client.name) then
                table.insert(names, client.name)
            end
        end

        if #names > 0 then
            return table.concat(names, ', ')
        else
            return 'NOLSP'
        end
    end,

    on_click = function()
        vim.api.nvim_command('LspInfo')
    end
}

M.filename = {
    'filename',
    symbols = {
        modified = " ●"
    },
    fmt = function(str)
        for _, v in ipairs(fts) do
            if vim.bo.filetype == v then
                return ""
            end
        end

        return str
    end
}

M.diff = {
    'diff',
    symbols = {
        added = "",
        modified = "",
        removed = ""
    },
    fmt = function(str)
        if vim.g.DiffviewOpen then
            return ""
        end

        return str
    end,
}

M.spaces = {
    function()
        local size = vim.api.nvim_buf_get_option(0, "shiftwidth")
        if size == 0 then
            size = vim.api.nvim_buf_get_option(0, "tabstop")
        end
        return "⇥ " .. size
    end,
    color = { fg = '#e07016' }
}

M.filetype = {
    'filetype',
    icon = { align = 'right' },

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

return M
