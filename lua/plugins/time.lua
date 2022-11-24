local TIME = {}

local path = vim.fn.stdpath('data') .. '/time/time.json'

TIME.autocmds = function()

    vim.g.autocmd("VimEnter", {
        callback = function()
            vim.g.open_at = os.time()
        end
    })

    vim.g.autocmd("QuitPre", {
        callback = function()
            vim.fn.writefile(TIME.create_json(), path)
        end
    })
end

TIME.total_time = function()
    local val = vim.fn.json_decode(
        vim.fn.readfile(path)
    ).total

    return val
end

TIME.create_json = function()
    return { vim.fn.json_encode({
        ["total"] = TIME.total_time() + os.difftime(os.time(), vim.g.open_at)
    }) }
end

return TIME
