local M = {}

M.current_history = nil

local history_path = string.format(
    "%s/rooter.json",
    vim.fn.stdpath('data')
)

M.get_history = function()
    -- if not vim.fn.filereadable(history_path) or
    --     vim.fn.wordcount().chars < 2 then

    --     vim.fn.writefile({ vim.fn.json_encode({}) }, history_path)
    -- end

    return vim.fn.json_decode(
        vim.fn.readfile(history_path)
    )
end

M.find_decent_name = function(names, path)
    local spt = vim.split(path, '/')
    local name
    local i = 0

    -- si le nom du dossier est déjà emprunté je remonte
    while not name and vim.tbl_contains(names, name) do
        local tmp = ""
        i = i + 1

        for j = #spt, #spt - i, -1 do
            tmp = string.format("%s/%s", spt[j], tmp)
        end

        name = tmp
    end

    return name or vim.fs.basename(path)
end

M.save_project = function(path)
    local history = M.get_history()
    local name = M.find_decent_name(vim.tbl_keys(history), path)

    history[name] = path

    vim.fn.writefile(
        { vim.fn.json_encode(history) },
        history_path
    )
end


M.is_inside_saved_project = function()
    local current = vim.fn.expand('%:p')

    local history = vim.tbl_values(
        M.get_history()
    )

    -- le cas de base est "/"
    -- mais dans telescope par example le chemin est "."?????
    while string.len(current) > 1 do
        if vim.tbl_contains(history, current) then
            return current
        end

        current = vim.fn.fnamemodify(current, ':h')
    end

    return false
end

M.get_project_root = function()
    local result = vim.fs.find(u.ft.patterns, {
        upward = true,
        path = vim.fn.expand('%:p'),
        stop = vim.fn.expand('$HOME'),
        limit = 2
    })

    if result then
        return vim.fs.dirname(result[1])
    end

    return false
end

M.main = function()
    local saved = M.is_inside_saved_project()

    if saved then
        return saved
    end

    -- get_project_root est beaucoup moins rapide
    -- car iter sur les fichiers
    local search = M.get_project_root()

    if search then
        return search
    end
end

M.autocmds = function()

    vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
            local cmd = M.main()

            if cmd then
                nvim.command("lcd " .. cmd)
                -- vim.cmd.lcd = cmd
            end
        end
    })

end

M.keymaps = function()

    vim.g.nmap("<leader>cd", function()
        local root = M.get_project_root()

        if not M.is_inside_saved_project() and root then
            if vim.fn.input(root .. " [y/n]: ") == "y" then
                M.save_project(root)
            end
        end

    end)

end

return M
