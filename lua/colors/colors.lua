local M = {}

function M.setup()

    return {
        all = {
            LineNr = {guifg = '#6B6B6B'},
            BiscuitColor = {guifg = '#383838'},
            VertSplit = {guifg = '#6B6B6B'};
            Normal = {guifg = '#EEEEEE', guibg = '#080808'},
        },
        spacecamp = {
            NonText = {guifg = '#6B6B6B'},
            DiffAdd = {guibg = '#203617'},
            DiffDelete = {guibg = '#800707'},
            DiffChange = {guibg = '#992F0A'},
            DiffText = {guibg = '#000033'},
            MatchParen = {guifg = '#F0D50C'},
            Todo = {guifg = '#CF73E6'},
            CocUnusedHighlight = {gui = 'underline'},
            CocHintHighlight = {cterm = 'undercurl', guisp ='#000000'},
        },
        gruvbox = {
            Visual = {ctermbg = 0, guibg = 'Grey40'},
            CocHintFloat = {}
        }
    }

end

return M
