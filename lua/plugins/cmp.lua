local M = {}

local cmp = require('cmp')
local luasnip = require("luasnip")
local tabnine = require('cmp_tabnine.config')

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
            { name = "nvim_lsp", max_item_count = 6 },
            { name = "cmp_tabnine" },
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
        }
    }

    tabnine:setup({
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = '..',
        show_prediction_strength = true
    })

end

return M
