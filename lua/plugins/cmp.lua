local M = {}

local fn = require('fn')
local cmp = fn.lazy_require('cmp')
local luasnip = fn.lazy_require("luasnip")

function M.config()

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
            { name = "luasnip" },
            { name = "cmp_tabnine" },
            { name = "nvim_lsp", max_item_count = 6 },
            { name = "buffer", max_item_count = 6 },
            { name = "path" },
            { name = "calc" }
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end
        },
        window = {
            completion = cmp.config.window.bordered()
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
                menu = {
                    cmp_tabnine = "[tabnine]",
                    path = "[path]",
                    calc = "[calc]",
                    nvim_lsp = "[lsp]",
                    luasnip = "[snip]",
                }
            }
        },
        experimental = {
            ghost_text = true
        }
    }
end

return M
