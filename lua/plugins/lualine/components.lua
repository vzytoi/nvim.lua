local M = {}

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
            table.insert(names, client.name)
        end

        return table.concat(names, ', ')
    end,

    on_click = function()
        vim.api.nvim_command('LspInfo')
    end

}

M.filename = {
    function()
        local fn = vim.fn.expand('%:t')

        if string.find(fn, 'NvimTree') then
            fn = 'NvimTree'
        end

        return fn
    end,

    symbols = {
        modified = " ●"
    }
}

return M
