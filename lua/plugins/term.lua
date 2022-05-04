local M = {}

function M.setup()
    local map = {
        {
            "<leader>",
            {
                {"t", ":ToggleTerm direction=tab<cr>"},
                {
                    "t",
                    {
                        {"f", ":ToggleTerm direction=float<cr>"},
                        {"s", ":ToggleTerm direction=horizontal<cr>"},
                        {"v", ":ToggleTerm direction=vertical<cr>"}
                    }
                }
            }
        },
        {
            mode = "t",
            {
                {"<c-t>", [[<C-\><C-n>:q!<cr>]]},
                {"<esc>", [[<C-\><C-n>]]},
                {"<c-v>", [[<C-\><C-n>"*pA"]]}
            }
        }
    }

    return map
end

function M.config()
    require("toggleterm").setup {
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
end

return M
