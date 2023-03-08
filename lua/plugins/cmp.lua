local M = {}

local cmp = require('cmp')
local neogen = require('neogen')

M.config = function()
    local luasnip = require('luasnip')

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
        sources = {
            { name = "copilot" },
            { name = "luasnip",                 max_item_count = 2 },
            { name = "nvim_lsp",                max_item_count = 2 },
            { name = 'nvim_lsp_signature_help', max_item_count = 2 },
            { name = "treesitter",              max_item_count = 2 },
        },
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
            ["<tab>"] = cmp.mapping(
                function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif cmp.visible() then
                        cmp.confirm { select = true }
                    elseif neogen.jumpable() then
                        neogen.jump_next()
                    else
                        fallback()
                    end
                end, { "i", "s" }
            ),
            ["<s-tab>"] = cmp.mapping(
                function(fallback)
                    if luasnip.jumpable( -1) then
                        luasnip.jump( -1)
                    elseif neogen.jumpable(true) then
                        neogen.prev()
                    else
                        fallback()
                    end
                end, { "i", "s" }
            )
        },
        experimental = {
            ghost_text = true
        },
    }
end

return M
