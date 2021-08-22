local M = {}

function M.config()

    local t = {
        { 'spacecamp', 'codedark' }
    }

    local c

    for _, v in ipairs(t) do
        if v[1] == vim.g.colors_name then
            c = v[2]
        end
    end

    if c == nil then
        c = t[math.random(1, #t)][2]
    end

    require('lualine').setup {
        options = {
            theme = c
        }
    }

end

return M
