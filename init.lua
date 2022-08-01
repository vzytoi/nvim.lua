require('impatient').enable_profile()
vim.func = require('utils.fn')

local modules = {
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

for _, m in pairs(modules) do
    if not m.event then
        load(m.name)
    else
        vim.api.nvim_create_autocmd(m.event, {
            callback = function()
                if vim.g[m.name] == nil then
                    load(m.name)
                end
            end
        })
    end
end
