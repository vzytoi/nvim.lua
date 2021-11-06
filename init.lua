local function autocmd(name, event)

    vim.cmd(
        string.format(
            "autocmd %s * lua require('%s').config()",
        event, name
        )
    )

end

local function init()

    local files = {
        {"colors", event = "ColorScheme" },
        {"abbr", event = "CmdLineEnter" },
        {"options"},
        {"autocmd" },
        {"plugins" },
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

-- TODO: je veux que lorsque l'on ouvre vim avec un dossier
-- comme argument, coc-explorer soit affiché
-- et non pas un fichier vide. (05/11/2021 23:47:04)
