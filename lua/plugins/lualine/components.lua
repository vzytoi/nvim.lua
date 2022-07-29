local M = {}

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
    end
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
    }
}

M.diff = {
    'diff',
    symbols = {
        added = "",
        modified = "",
        removed = ""
    }
}

M.filetype = {
    'filetype',
    icon = { align = 'right' }
}

return M
