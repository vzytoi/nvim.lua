local modules = {
    { name = "colors", event = "Colorscheme", once = false },
    { name = "opts" },
    { name = "plugins" },
    { name = "autocmds" },
    { name = "abbr", event = "cmdlineenter", once = true },
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
                if not m.once or vim.g[m.name] == nil then
                    load(m.name)
                end
            end
        })
    end
end

-- TODO: lsp only on current line;
-- TODO: php formatter?;
-- TODO: <leader>xt to open "node #" in toggleterm in a new tab?????;
-- TODO: why rename doesn't work: https://neovim.discourse.group/t/tsserver-renaming-doesnt-work-attempt-to-index-a-boolean-value/2593;
-- TODO: spellsitter: https://github.com/wbthomason/packer.nvim/issues/899;
-- TODO: nvim-tree-docs: https://github.com/nvim-treesitter/nvim-tree-docs/issues/20;
-- TODO: telescope ignore gitingore;
-- TODO: nvim-tree show .exe files;
-- TODO: make nvim-tree rooter better;
-- TODO: enter normal mode when entering term if full screen;
-- TODO: check lua formatter to remove space around curly brackets;
-- TODO: remove all from here open nvim-tree
