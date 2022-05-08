local M = {}

function M.config()
    M.cmp = require("cmp")
    M.lspkind = require("lspkind")
    M.luasnip = require("luasnip")

    M.cmp.setup {
        sources = {
            {name = "luasnip"},
            {name = "cmp_tabnine"},
            {name = "nvim_lsp"},
            {name = "buffer"},
            {name = "path"},
            {name = "calc"}
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end
        },
        window = {
            completion = M.cmp.config.window.bordered()
        },
        mapping = {
            ["<c-k>"] = M.cmp.mapping.select_prev_item(),
            ["<c-j>"] = M.cmp.mapping.select_next_item(),
            ["<tab>"] = M.cmp.mapping(
                function(fallback)
                    if M.cmp.visible() then
                        M.cmp.confirm({select = true})
                    elseif M.luasnip.expand_or_jumpable() then
                        M.luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end
            )
        },
        formatting = {
            format = M.lspkind.cmp_format {
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
