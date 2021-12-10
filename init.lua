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

require('packer_compiled')

-- TODO: idée: faire un plugin manager de session
-- on pourrait enregistrer les sessions sous des noms ou bien
-- charger la dernière sauvegardée. (07/12/2021 18:10:04)

-- TODO: lua formatting (07/12/2021 19:10:28)

-- TODO: indent when moving lines (07/12/2021 19:10:28)
