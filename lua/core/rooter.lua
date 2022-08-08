local ROOT = {}

local options = {
    history_path = vim.fn.stdpath('data') .. '/rooter/history',
    targets = { '.git', '.gitignore', 'README.md' }
}

local write = function(root)
    vim.fn.writefile({ root }, options.history_path, "a")
end

local read = function()
    return vim.fn.readfile(options.history_path)
end

ROOT.search_root = function(add)

    if not vim.bo.modifiable or vim.bo.readonly
        or vim.fn.bufname() == "" then
        return
    end

    local path = vim.fs.normalize(
        vim.fn.expand('%:p:h')
    )

    for parent, _ in vim.fs.parents(path) do

        if vim.tbl_contains(read(), parent) then
            vim.cmd.cd(parent)
            return
        end

        if not add then
            goto continue
        end

        for name, _ in vim.fs.dir(parent) do

            if vim.tbl_contains(options.targets, name) and
                vim.fn.input(parent .. " ? Y/N ") == "Y" then

                vim.cmd.cd(parent)
                write(parent)

                return
            end
        end

        ::continue::
    end

end

ROOT.keymaps = function()

    vim.g.nmap("<leader>cd", function()
        require('core.rooter').search_root(true)
    end)

end

ROOT.autocmds = function()

    vim.g.autocmd("BufEnter", {
        callback = function()
            require('core.rooter').search_root(false)
        end
    })

end

return ROOT
