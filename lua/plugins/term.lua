local M = {}

function M.setup()

    local map = {

        { '<leader>', {

            { 't', {
                { 'f', ':ToggleTerm direction=float<cr>' },
                { 'h', ':ToggleTerm direction=horizontal<cr>' },
                { 'v', ':ToggleTerm direction=vertical<cr>' }
            }},
            { 't', ':ToggleTerm direction=window<cr>' }
        }}
    }

    return map

end

function M.config()

    require('toggleterm').setup{
        insert_mappings = false,
        hide_numbers = true,
        size = function(term)
            if term.direction == "vertical" then
                return 100
            elseif term.direction == "horizontal" then
                return 20
            end
        end
    }

end

return M
