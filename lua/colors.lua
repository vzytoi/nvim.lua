local M = {}

function M.config()

    vim.o.termguicolors = true
    vim.o.background = 'dark'

    vim.cmd('colorscheme spacecamp')

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
        },
    }

    for i, _ in ipairs(hi) do
        if hi[i]["Name"] == vim.g.colors_name then
            M.hi = hi[i]
        end
    end

    for m, _ in pairs(M.hi) do
        if m ~= "Name" then
            local s = 'hi ' .. m
            for k, v in pairs(M.hi[m]) do
                s = s .. ' ' .. table.concat({k,v}, '=')
            end
            vim.cmd('hi clear ' .. m)
            vim.cmd(s)
        end
    end

end

return M.config()
