local M = {}

local colors = require('plugins.lualine.themes').colors[vim.g.colors_name]

local filter = function()
    return not vim.tbl_contains({ 'harpoon' }, vim.bo.filetype)
        and vim.bo.modifiable and not vim.bo.readonly
        and vim.fn.bufname() ~= ""
end

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
    cond = filter,
}

local function lsp(switch)

    if #vim.lsp.buf_get_clients() > 0 then
        return (switch and "" or "")
    else
        return (not switch and "" or "")
    end

end

M.lsp = {
    on = {
        function() return lsp(true) end,
        color = { fg = colors.green },
        on_click = function()
            vim.api.nvim_command('LspInfo')
        end,
        cond = filter
    },
    off = {
        function() return lsp(false) end,
        color = { fg = colors.red },
        on_click = function()
            vim.api.nvim_command('LspInstall')
        end,
        cond = filter
    }
}

M.filename = {
    'filename',
    symbols = {
        modified = " ●"
    },
    cond = filter,
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
        vim.g.fn.toggle("DiffviewOpen", "DiffviewClose")
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
    color = { fg = colors.cyan },
    cond = filter,
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

local format = function(switch)
    local fconfig = require('formatter.config')
    local exe = false

    for ft, _ in pairs(fconfig.values.filetype) do
        if ft ~= "*" and ft == vim.bo.filetype then
            exe = true
        end
    end

    if vim.g.fn.capabilities('format', 0) or exe then
        return (switch and "⍟" or "")
    else
        return (not switch and "⍟" or "")
    end
end

M.format = {
    on = {
        function() return format(true) end,
        color = { fg = colors.green },
        cond = filter
    },
    off = {
        function() return format(false) end,
        color = { fg = colors.red },
        cond = filter
    }
}

return M
