local function autocmd(name, event)

    vim.cmd(
        string.format(
            'autocmd %s * lua require("%s").config()',
            event, name
        )
    )

end

local function init()

    local files = {
        {'autocmds' },
        {'options'},
        {'plugins' },
        {'colors', event = 'ColorScheme' },
        {'abbr', event = 'CmdLineEnter' },
    }

    for _, f in pairs(files) do

        if not f.event then
            require(f[1]).config()
        else
            autocmd(f[1], f.event)
        end

    end

end

init()
