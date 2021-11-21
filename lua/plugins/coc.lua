local M = {}

local function open(pos)

    vim.api.nvim_command(
        string.format("CocCommand explorer --position %s",
        pos)
    )

    vim.g.side = pos

end

function M.setup()

    local map = {
        { '<leader>', {
            { options = { noremap = false }, {
                { mode = 'x', {
                    { 'i', '<Plug>(coc-format-selected)' }
                }},
                { 'i', {
                    { 'c', '<Plug>(coc-format)' },
                }},
                { 'c', {
                    { 'd', '<Plug>(coc-definition)' },
                    { 'f', '<Plug>(coc-references)' },
                    { 'r', '<Plug>(coc-rename)' },
                    { 'j', '<Plug>(coc-diagnostic-next)' },
                    { 'k', '<Plug>(coc-diagnostic-prev)' },
                    { 'i', '<Plug>(coc-implementation)' },
                    { 't', '<Plug>(coc-type-definition)' },
                }},
                { 'e', function()

                    if vim.g.explorer_is_open == 1 then
                        vim.api.nvim_command(
                            'CocCommand explorer --position ' .. vim.g.side
                        )
                        return false
                    end

                    local wcount = vim.fn.winnr('$')
                    local wcurr = vim.fn.winnr()

                    open(
                        (wcurr > math.ceil(wcount / 2) or wcurr == wcount)
                        and 'right' or 'left'
                    )

                end}
            }}
        }}
    }

    return map

end

function M.config()

    vim.g.coc_global_extensions = {
        'coc-tsserver', 'coc-prettier',
        'coc-json', 'coc-pyright', 'coc-explorer',
        'coc-go', 'coc-clangd',
        'coc-phpls', 'coc-html', 'coc-css', 'coc-sql'
    }

end

return M
