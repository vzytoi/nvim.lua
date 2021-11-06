local M = {}

function M.setup()

    local map = {

        { '<leader>', {
            { 't', ':ToggleTerm direction=tab<cr>' },
            { 't', {
                { 'f', ':ToggleTerm direction=float<cr>' },
                { 's', ':ToggleTerm direction=horizontal<cr>' },
                { 'v', ':ToggleTerm direction=vertical<cr>' }
            }},
        }}
    }

    return map

end

function M.config()

    require('toggleterm').setup{

        hide_numbers = true,
        start_in_insert = true,
        close_on_exit = true,

        size = function(term)
            if term.direction == "vertical" then
                return 100
            elseif term.direction == "horizontal" then
                return 20
            end
        end
    }

    function _G.set_terminal_keymaps()

        local map = {
            ['<leader>t'] = [[<C-\><C-n>:q!<cr>]],
            ['<esc>'] = [[<C-\><C-n>]]
        }

        local opts = {
            noremap = true
        }

        for k, v in pairs(map) do
            vim.api.nvim_buf_set_keymap(
                0, 't', k, v, opts
            )
        end

    end

end

return M
