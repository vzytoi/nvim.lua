require('utils.globals')
vim.g.mapleader = " "

local mods = {
    { name = "abbr",     event = "CmdlineEnter" },
    { name = "colors",   event = "ColorScheme" },
    { name = "options" },
    { name = "packer" },
    { name = "autocmds", },
}

-- TODO: cursor moving on save
-- TODO: remove lsp_signature when :MP
-- TODO: solve vim global variable

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
                if not vim.g[m.name] then
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
