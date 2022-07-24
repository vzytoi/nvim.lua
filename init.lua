vim.g.mapleader = " "

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
                if vim.g[m.name] == nil then
                    load(m.name)
                end
            end
        })
    end
end
