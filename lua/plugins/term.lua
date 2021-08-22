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
