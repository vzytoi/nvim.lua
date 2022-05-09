local modules = {
    { name = "plugins" },
    { name = "autocmds" },
    { name = "options" },
    { name = "abbr", event = "cmdlineenter" }
}

local load = function(name)
    local ok, _ = pcall(require, name)
    if not ok then
        error("Could not load " .. name)
    else
        require(name).config()
    end
end

for _, m in pairs(modules) do
    if not m.event then
        load(m.name)
    else
        vim.api.nvim_create_autocmd( m.event, {
            callback = function()
                load(m.name)
            end
        })
    end
end

-- TODO lsp only on current line
-- TODO: php formatter?
-- TODO: <leader>xt to open "node #" in toggleterm in a new tab?????
