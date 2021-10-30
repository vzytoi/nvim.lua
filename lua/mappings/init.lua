local nest = require("nest")

vim.g.mapleader = " "

nest.defaults = {
    mode = "n",
    prefix = "",
    options = {
        noremap = true,
        silent = true
    }
}

function QueryMappings()

    local setups = {
        "telescope",
        "coc",
        "term",
        "runcode",
        "resize"
    }

    local map = {}

    for _, s in pairs(setups) do
        table.insert(
            map,
            require("plugins." .. s).setup()[1]
        )
    end

    table.insert(map, require("mappings.mappings"))

    return map

end

nest.applyKeymaps {
    QueryMappings()
}
