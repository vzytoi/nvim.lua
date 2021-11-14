local M = {}

local function feedkey(key, mode)
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(key, true, true, true),
    mode, true)
end

function M:config()

    M.cmp = require('cmp')
    M.lspkind = require('lspkind')

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
            { name = 'buffer', keyword_length = 5},
            { name = 'calc' }
        },
        mapping = {
            ['<c-k>'] = M.cmp.mapping.select_prev_item(),
            ['<c-j>'] = M.cmp.mapping.select_next_item(),
            ['<CR>'] = M.cmp.mapping.confirm({
                behavior = M.cmp.ConfirmBehavior.Replace,
                select = true,
            })
        },
        formatting = {
            format = M.lspkind.cmp_format {
                with_text = false,
                menu = {
                    cmp_tabnine = "[tabnine]",
                    ultisnips = "[snip]",
                    buffer = "[buf]",
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

function M:tabnine_config()

    M.tabnine = require('cmp_tabnine.config')

    M.tabnine:setup({
        max_lines = 1000;
        max_num_results = 5;
        sort = true;
        run_on_every_keystroke = true;
        snippet_placeholder = '..';
    })

end

return M
