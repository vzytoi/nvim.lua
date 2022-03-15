local M = {}

local function feedkey(key, mode)
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(key, true, true, true),
    mode, true)
end

function M.config()

    M.cmp = require('cmp')
    M.lspkind = require('lspkind')
    M.lspmap = require("cmp_nvim_ultisnips.mappings")

    M.cmp.setup {
        snippet = {
            expand = function(args)
                vim.fn['UltiSnips#Anon'](args.body)
            end
        },
        sources = {
            { name = 'cmp_tabnine' },
            { name = 'ultisnips' },
            { name = 'path' },
            { name = 'calc' },
        },
        mapping = {
            ['<c-k>'] = M.cmp.mapping.select_prev_item(),
            ['<c-j>'] = M.cmp.mapping.select_next_item(),
            ['<tab>'] = M.cmp.mapping.confirm({
                behavior = M.cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            ["<c-s>"] = M.cmp.mapping(
                function(fallback)
                    M.lspmap.compose{"expand"}(fallback)
                end,
                { "i", "s" }
            ),
        },
        formatting = {
            format = M.lspkind.cmp_format {
                with_text = false,
                menu = {
                    cmp_tabnine = "[tabnine]",
                    ultisnips = "[snip]",
                    path = "[path]",
                    calc = "[calc]"
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
