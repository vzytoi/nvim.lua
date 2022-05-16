local M = {}

function M.config()

    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local luasnip = require("luasnip")

    cmp.setup {
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
            format = lspkind.cmp_format {
                with_text = false,
                menu = {
                    cmp_tabnine = "[tabnine]",
                    path = "[path]",
                    calc = "[calc]",
                    nvim_lsp = "[lsp]",
                    luasnip = "[snip]"
                }
            }
        },
        experimental = {
            ghost_text = true
        }
    }
end

return M
