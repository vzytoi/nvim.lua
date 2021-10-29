local M = {}

function M.colorscheme()
    return {
        ['spacecamp'] = {
            ['Normal'] = {guifg = '#EEEEEE', guibg = '#080808'},
            ['NonText'] = {guifg = '#6B6B6B'},
            ['SignColumn'] = {},
            ['LineNr'] = {guifg = '#6B6B6B'},
            ['MatchParen'] = {guifg = '#F0D50C'},
            ['VertSplit'] = {guifg = '#6B6B6B'},
            ['Todo'] = {guifg = '#CF73E6'},
            ['CocUnusedHighlight'] = {gui='underline'},
            ['CocHintHighlight'] = {cterm = 'undercurl', guisp='#000000'}
        }
    }
end

function M.config()

    vim.o.termguicolors = true
    vim.o.background = 'dark'

    vim.cmd('colorscheme spacecamp')

    local opt = {
        'guifg', 'guibg', 'gui', 'guisp', 'cterm'
    }

    local hi = M.colorscheme()

    for name, _ in pairs(hi) do
        if name == vim.g.colors_name then
            M.hi = hi[name]
        end
    end

    for m, _ in pairs(M.hi) do
        vim.cmd(
            string.format("hi clear %s", m)
        )
    end

    for m, _ in pairs(M.hi) do
        local s = string.format('hi %s', m)

        for _, o in pairs(opt) do
            local v = 'none'
            if M.hi[m][o] ~= nil then
                v = M.hi[m][o]
            end
            s = s .. ' ' .. table.concat({o, v}, '=')
        end

        vim.cmd(s)
    end

end

return M.config()
