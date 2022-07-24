vim.g.mapleader = " "

local modules = {
    { name = "plugins" },
    { name = "colors", event = "colorscheme", once = false },
    { name = "opts" },
    { name = "autocmds" },
    { name = "abbr", event = "cmdlineenter", once = true },
}

local fn = require('fn')

local load = function(name)
    local ok, _ = pcall(require, name)
    if not ok then
        error("Could not load " .. name)
    else
        require(name).config()
        vim.g[name] = true
    end
end

for _, m in pairs(modules) do
    if not m.event then
        load(m.name)
    else
        vim.api.nvim_create_autocmd(m.event, {
            callback = function()
                if not m.once or vim.g[m.name] == nil then
                    load(m.name)
                end
            end
        })
    end
end
