local M = {}

local cmp = require('cmp')
local luasnip = require("luasnip")

M.config = function()

    cmp.setup {
        completion = {
            completeopt = 'menu,menuone,noselect',
            get_trigger_characters = function(trigger_characters)
                return vim.tbl_filter(function(char)
                    return char ~= ' '
                end, trigger_characters)
            end,
        },
        sources = {
            { name = "nvim_lsp", max_item_count = 2 },
            { name = "cmp_tabnine", max_item_count = 2 },
            { name = "rg" },
            { name = "nvim_lua" },
            { name = "luasnip" },
            { name = "buffer", max_item_count = 6 },
            { name = "path" },
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end
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
                        cmp.confirm({ select = true })
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end
            )
        },
        formatting = {
            format = require('lspkind').cmp_format {
                with_text = false,
                mode = 'symbol',
            }
        },
        experimental = {
            ghost_text = true
        },
        enable = function()
            local context = require 'cmp.config.context'
            if nvim.get_mode().mode == 'c' then
                return true
            else
                return not context.in_treesitter_capture("comment")
                    and not context.in_syntax_group("Comment")
            end
        end
    }

end


return M
