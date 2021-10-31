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

    local map = {
        "telescope", "coc",
        "term", "runcode",
        "resize", "mappings/mappings"
    }

    for i, m in pairs(map) do

        if not string.find(m, "/") then
            m = string.format('plugins.%s', m)
        end

        map[i] = require(m).setup()
    end

    return map

end

nest.applyKeymaps {
    QueryMappings()
}
