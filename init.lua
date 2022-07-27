vim.g.fn = require('fn')

local modules = {
    { name = "abbr", event = "cmdlineenter" },
    { name = "colors", event = "ColorScheme" },
    { name = "plugins" },
    { name = "opts" },
    { name = "autocmds" },
}

local load = function(name)
    local ok, _ = pcall(require, name)
    if not ok then
        vim.api.nvim_error_writeln("Failed to load" .. name)
    else
        vim.g[name] = require(name)
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
