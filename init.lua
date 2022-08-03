require('impatient').enable_profile()

vim.func = require('utils.fn')
vim.colors = require('utils.colors')

local mods = {
    { name = "abbr", event = "cmdlineenter" },
    { name = "colors", event = "ColorScheme" },
    { name = "plugins" },
    { name = "opts" },
    { name = "autocmds" },
}

local load = function(name)
    local ok, _ = pcall(require, 'core.' .. name)
    if not ok then
        print("Failed to load " .. name)
    else
        vim.g[name] = require('core.' .. name)
        vim.g[name].config()
    end
end

for _, m in pairs(mods) do

    if not m.event then
        load(m.name)
    else
        vim.api.nvim_create_autocmd(m.event, {
            callback = function()
                if vim.g[m.name] == nil then
                    load(m.name)
                end
            end,
            group = vim.api.nvim_create_augroup(
                "Loading" .. m.name,
                { clear = true }
            )
        })
    end
end

-- TODO: fix resize
-- TODO: lazy load telescope
-- TODO: definition => close qf
-- TODO: remove comments when pressing o
-- TODO: use K to go to parent directory nvimtree
