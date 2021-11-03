local M = {}

function M.setup()

    local map = {
        { '<leader>', {
            { options = { noremap = false }, {
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
                { 'e', ':CocCommand explorer<cr>'}
            }}
        }}
    }

    return map

end

function M.config()

    vim.g.coc_global_extensions = {
        'coc-tsserver', 'coc-prettier',
        'coc-json', 'coc-pyright', 'coc-explorer',
        'coc-tabnine', 'coc-go', 'coc-clangd',
        'coc-phpls', 'coc-html', 'coc-css', 'coc-sql'
    }

end

return M
