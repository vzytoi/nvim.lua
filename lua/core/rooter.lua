local ROOT = {}

local options = {
    history_path = vim.fn.stdpath('data') .. '/rooter/history',
    targets = { '.git', '.gitignore', 'README.md', 'dune-project', 'dune-workspace' }
}

local write = function(path)
    vim.fn.writefile({ path }, options.history_path, "a")
end

local read = function()
    return vim.fn.readfile(options.history_path)
end

ROOT.search_root = function(add)

    if u.fun.unwanted(vim.fn.bufnr()) then
        return
    end

    local path = vim.fs.normalize(
        vim.fn.expand('%:p:h')
    )

    for parent, _ in vim.fs.parents(path) do

        if vim.tbl_contains(read(), parent) then
            vim.cmd.lcd(parent)
            return
        end
        if not add then
            goto continuel1
        end

        for name, _ in vim.fs.dir(parent) do

            if vim.tbl_contains(options.targets, name) then
                if vim.fn.input(parent .. " ? y/n ") == "y" then

                    vim.cmd.lcd(write(parent))

                    return
                else
                    goto continuel1
                end
            end

        end

        ::continuel1::
    end

    if add then
        vim.cmd.lcd(write(vim.fn.input("", path)))
    else
        vim.cmd.lcd(path)
    end

end

ROOT.keymaps = function()

    vim.g.nmap("<leader>cd", function()
        require('core.rooter').search_root(true)
    end)

end

ROOT.autocmds = function()

    vim.g.autocmd({ "DirChanged", "BufEnter" }, {
        callback = function()
            require('core.rooter').search_root(false)
        end
    })

end

return ROOT
