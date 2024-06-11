local M = {}

M.load =
{
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
        require("plugins.cmp").config()
    end,
    dependencies = {
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "rafamadriz/friendly-snippets"
    }
}

M.config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup {
        completion = {
            completeopt = 'menu,menuone,noselect',
            get_trigger_characters = function(trigger_characters)
                return vim.tbl_filter(function(char)
                    return char ~= ' '
                end, trigger_characters)
            end,
        },
        performance = { max_view_entries = 3 },
        sources = {
            { name = "nvim_lsp",
                -- on veut pas des snippets du lsp par défaut
                entry_filter = function(entry)
                    return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
                end
            },
            { name = 'nvim_lsp_signature_help' },
            { name = "luasnip" }
        },
        view = { entries = "wildmenu" },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end
        },
        mapping = {
            ["<c-k>"] = cmp.mapping.select_prev_item(),
            ["<c-j>"] = cmp.mapping.select_next_item(),
            ["<tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.confirm { select = true }
                elseif luasnip.locally_jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, { "i", "s" }
            ),
            ["<s-tab>"] = cmp.mapping(
                function(fallback)
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }
            )
        },
        experimental = {
            ghost_text = true
        },
        enabled = function()
            local context = require("cmp.config.context")
            return not (context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
        end
    }
end

return M
