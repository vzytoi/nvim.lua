local M = {}

M.linters = {
    python = 'flake8'
}

M.autocmds = function()
    vim.api.nvim_create_autocmd({ "BufWritePost", "CursorHold", "InsertLeave", "DiagnosticChanged" }, {
        callback = function()
            require("lint").try_lint()
        end,
    })
end

M.config = function()
    require('lint').linters_by_ft = {
        python = { M.linters.python }
    }
end

M.get = function()
    return M.linters[u.fun.buf('filetype')] or ''
end

return M
