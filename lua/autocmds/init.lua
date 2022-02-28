local M = {}
local utils = require('utils')

local function closeBuffersList()

    local closeAutocmd = {
        'BufEnter',
        '*',
        'if (winnr("$") == 1 && &filetype == "%s") | q | endif'
    }

    local ftList = {
        _close = {
            'packer', 'git-commit', 'coc-explorer',
            'fugitive', 'startuptime', 'qf', 'diff',
            'toggleterm'
        }
    }

    local current

    for k, ft in ipairs(ftList['_close']) do

        current = string.format(
            closeAutocmd[3],
            ft
        )

        ftList['_close'][k] = {
            {closeAutocmd[1], closeAutocmd[2], current}
        }

    end

    return ftList

end

local function setAutocmd(gp, def)

        vim.cmd('augroup ' .. gp)
        vim.cmd('autocmd!')

        for _, defi in pairs(def) do

            vim.cmd(
                table.concat(
                    vim.tbl_flatten{"autocmd", defi}, " "
                )
            )
        end

        vim.cmd('augroup END')

end

M.config = function()

    local autocmdsList = utils.mergeTables(
        closeBuffersList(),
        require('autocmds.autocmds').setup()
    )

    for gp, def in pairs(autocmdsList) do
        setAutocmd(gp, def)
    end

end

return M
