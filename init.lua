local function autocmd(name, event)
    vim.api.nvim_create_autocmd(
        event,
        {
            callback = function()
                require(name).config()
            end
        }
    )
end

local function init()
    local files = {
        {name = "plugins"},
        {name = "autocmds"},
        {name = "options"},
        {name = "abbr", event = "cmdlineenter"}
    }

    for _, f in pairs(files) do
        if not f.event then
            require(f.name).config()
        else
            autocmd(f.name, f.event)
        end
    end
end

init()

-- TODO lsp only on current line
-- TODO: php formatter?
-- TODO: <leader>xt to open "node #" in toggleterm in a new tab?????
