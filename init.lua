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
        {'plugins'},
        {'autocmds'},
        {'options'},
        {'colors', event = 'colorscheme' },
        {'abbr', event = 'cmdlineenter' },
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
