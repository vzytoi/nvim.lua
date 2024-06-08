local M = {}

M.load =
{
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
        require("plugins.cmp").config()
    end,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "lukas-reineke/cmp-rg",
        "ray-x/cmp-treesitter",
        {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            config = function()
                require("copilot").setup {
                    cmp = { enabled = true, method = "getCompletionsCycling", },
                    panel = { enabled = false, },
                    suggestion = { enabled = false, },
                }
            end
        },
        {
            "zbirenbaum/copilot-cmp",
            after = { "copilot.lua" },
            config = function()
                require("copilot_cmp").setup()
            end
        },
    }
}

M.config = function()
    local cmp = require('cmp')

    cmp.setup {
        disabled = function()
            return vim.bo.filetype == "c"
        end,
        completion = {
            completeopt = 'menu,menuone,noselect',
            get_trigger_characters = function(trigger_characters)
                return vim.tbl_filter(function(char)
                    return char ~= ' '
                end, trigger_characters)
            end,
        },
        performance = { max_view_entries = 10 },
        sources = {
            { name = "copilot" },
            { name = "nvim_lsp", },
            { name = 'nvim_lsp_signature_help' },
            { name = "treesitter", },
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
        mapping = {
            ["<c-k>"] = cmp.mapping.select_prev_item(),
            ["<c-j>"] = cmp.mapping.select_next_item(),
            ["<tab>"] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.confirm { select = true }
                    else
                        fallback()
                    end
                end, { "i", "s" }
            ),
            ["<s-tab>"] = cmp.mapping(
                function(fallback)
                        fallback()
                end, { "i", "s" }
            )
        },
        experimental = {
            ghost_text = true
        },
    }
end

return M
