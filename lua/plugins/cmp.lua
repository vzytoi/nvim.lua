local M = {}

local cmp = require('cmp')
local luasnip = require('luasnip')

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
            { name = 'luasnip', max_item_count = 2 },
            { name = 'nvim_lsp_signature_help', max_item_count = 2 },
            { name = "rg", max_item_count = 2 },
            { name = "treesitter", max_item_count = 2 },
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
                        cmp.confirm()
                    elseif luasnip.expand_or_jump() then
                        luasnip.expand_or_jump()
                    else
                        -- actually tab
                        fallback()
                    end
                end
            )
        },
        experimental = {
            ghost_text = true
        },
    }

end

return M
