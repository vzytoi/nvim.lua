local M = {}

function M.setup()

    local map = {
        { '<leader>', {
            { 'i', {
                { 'c', '<Plug>(coc-format)', options = { noremap = false } }
            }},
            { 'c', {
                { 'd', '<Plug>(coc-definition)', options = { noremap = false } },
                { 'f', '<Plug>(coc-references)', options = { noremap = false } },
                { 'r', '<Plug>(coc-rename)', options = { noremap = false } },
                { 'j', '<Plug>(coc-diagnostic-next)', options = { noremap = false } },
                { 'k', '<Plug>(coc-diagnostic-prev)', options = { noremap = false } },
                { 'i', '<Plug>(coc-implementation)', options = { noremap = false } },
                { 't', '<Plug>(coc-type-definition)', options = { noremap = false } }
            }},
            { 'e', ':CocCommand explorer<cr>' }
        }},
    }

    return map

end

function M.config()

    vim.g.coc_global_extensions = {
        'coc-sumneko-lua', 'coc-tsserver', 'coc-prettier',
        'coc-json', 'coc-explorer', 'coc-pyright',
        'coc-tabnine', 'coc-go', 'coc-clangd',
        'coc-phpls', 'coc-html', 'coc-css'
    }

end

return M
