local M = {}

function M.setup()

    local map = {
        { '<leader>', {
            { 'b', {
                { 'c', ':CocCommand prettier.formatFile<cr>' }
            }},
            { 'g', {
                { 'd', '<Plug>(coc-definition)', options = { noremap = false } },
                { 'f', '<Plug>(coc-references)', options = { noremap = false } },
                { 'r', '<Plug>(coc-rename)', options = { noremap = false } },
            }}
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
