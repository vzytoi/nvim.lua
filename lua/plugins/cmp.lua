local M = {}

function M.config()
    M.cmp = require("cmp")
    M.lspkind = require("lspkind")

    M.cmp.setup {
        sources = {
            {name = "cmp_tabnine"},
            {name = "nvim_lsp"},
            {name = "path"},
            {name = "calc"}
        },
        mapping = {
            ["<c-k>"] = M.cmp.mapping.select_prev_item(),
            ["<c-j>"] = M.cmp.mapping.select_next_item(),
            ["<tab>"] = M.cmp.mapping.confirm(
                {
                    behavior = M.cmp.ConfirmBehavior.Replace,
                    select = true
                }
            ),
            ["<c-s>"] = M.cmp.mapping(
                function(fallback)
                    M.lspmap.compose {"expand"}(fallback)
                end,
                {"i", "s"}
            )
        },
        formatting = {
            format = M.lspkind.cmp_format {
                with_text = false,
                menu = {
                    cmp_tabnine = "[tabnine]",
                    ultisnips = "[snip]",
                    path = "[path]",
                    calc = "[calc]",
                    nvim_lsp = "[lsp]"
                }
            }
        },
        experimental = {
            native_menu = false,
            ghost_text = true
        }
    }
end

return M
