local M = {}

M.current_history = nil

local history_path = string.format(
    "%s/rooter.json",
    vim.fn.stdpath('data')
)

M.get_history = function()
    return vim.fn.json_decode(
        vim.fn.readfile(history_path)
    )
end

M.save_project = function(path)
    local history = M.get_history()
    history[vim.fs.basename(path)] = path

    vim.fn.writefile({ vim.fn.json_encode(history) }, history_path)
end


M.get_project_root = function()
    local result = vim.fs.dirname(vim.fs.find(u.ft.patterns, {
        upward = true,
        path = u.fun.buf('filepath'),
        stop = vim.fn.expand('$HOME')
    })[1])

    M.save_project(result)

    return result
end

M.autocmds = function()

    vim.g.autocmd("WinEnter", {
        callback = function()
            -- nvim.command("cd " .. M.get_project_root())
        end
    })

end

return M
