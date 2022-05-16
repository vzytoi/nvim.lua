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
        vim.api.nvim_create_autocmd(m.event, {
            callback = function()
                load(m.name)
            end
        })
    end
end

-- TODO: lsp only on current line
-- TODO: php formatter?
-- TODO: <leader>xt to open "node #" in toggleterm in a new tab?????
-- TODO: why rename doesn't work: https://neovim.discourse.group/t/tsserver-renaming-doesnt-work-attempt-to-index-a-boolean-value/2593
-- TODO: spellsitter: https://github.com/wbthomason/packer.nvim/issues/899
-- TODO: nvim-tree-docs: https://github.com/nvim-treesitter/nvim-tree-docs/issues/20
-- TODO: limit severtiy for virtual text.
-- TODO: runcode use splitterm istead for color highlighting etc
-- TODO: runcode lang (rust) if !cargo vertify-project { rustc % } else { cargo run };
-- TODO: telescope ignore gitingore
-- TODO: nvim-tree show .exe files
-- TODO: make runcode autocmd lua
