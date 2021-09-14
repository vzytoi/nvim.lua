local M = {}

function M.config()

    local hi = {
        {
            ["Name"] = 'spacecamp',
            ["Normal"] = {
                guifg = "#EEEEEE", guibg = "#080808", gui = "none" },
            ["NonText"] = {
                guifg = '#6B6B6B', guibg = 'none', gui = 'none' },
            ["SignColumn"] = {
                guifg = 'none', guibg = 'none', gui = 'none', },
            ["LineNr"] = {
                guifg = '#6B6B6B', guibg='none', gui='none' },
            ["MatchParen"] = {
                guifg = '#F0D50C', guibg='none', gui='none' },
            ["VertSplit"] = {
                guifg = '#6B6B6B', guibg='none', gui='none' },
            ["Todo"] = {
                guifg = '#CF73E6', guibg='none', gui='none' },
            ["CocUnusedHighlight"] = {
                guibg = 'none', guifg='none', gui='underline' },
            ["CocHintHighlight"] = {
                cterm = 'undercurl', guisp='#000000', }
        }
    }

    for i, _ in ipairs(hi) do
        if hi[i]["Name"] == vim.g.colors_name then
            for m, t in ipairs(hi[i]) do
                vim.cmd('hi clear ' .. m)
                local s = 'hi ' .. m
                for k, v in pairs(t) do
                    s = s .. ' ' .. table.concat({k,v}, '=')
                end
                vim.cmd(s)
            end
        end
        break
    end

end

return M.config()
