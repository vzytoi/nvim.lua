local M = {}

function M.setup()

    local map = {
        { '<leader>', {
            { 'i', {
                { 'c', ':CocCommand prettier.formatFile<cr>' }
            }},
            { 'c', {
                { 'd', '<Plug>(coc-definition)', options = { noremap = false } },
                { 'f', '<Plug>(coc-references)', options = { noremap = false } },
                { 'r', '<Plug>(coc-rename)', options = { noremap = false } },
            }},
            { 'e', ':CocCommand explorer<cr>' }
        }}
    }

    return map

end

function M.config()

    vim.cmd [[
    let g:coc_global_extensions = [ 'coc-marketplace',
    \ 'coc-lua', 'coc-tsserver', 'coc-prettier', 'coc-json', 'coc-explorer']
    ]]

end

return M
