local M = {}

local cmp = require('cmp')
local luasnip = require('luasnip')
local neogen = require('neogen')

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
            { name = "copilot" },
            { name = "nvim_lsp", max_item_count = 2 },
            { name = 'luasnip', max_item_count = 2 },
            { name = 'nvim_lsp_signature_help', max_item_count = 2 },
            -- { name = "rg", max_item_count = 2 },
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
                    if luasnip.expand_or_jump() then
                        luasnip.expand_or_jump()
                    elseif cmp.visible() then
                        cmp.confirm { select = true }
                    elseif neogen.jumpable() then
                        neogen.jump_next()
                    else
                        -- actually tab
                        fallback()
                    end
                end, { "i", "s" }
            ),
            ["<s-tab>"] = cmp.mapping(
                function(fallback)
                    if neogen.jumpable(true) then
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

    require('luasnip.loaders.from_snipmate').load { paths = "~/.config/nvim/snippets" }

    require("luasnip.loaders.from_vscode").lazy_load {
        paths = { vim.fn.stdpath('data') .. "/site/pack/packer/start/friendly-snippets" }
    }


end

return M
