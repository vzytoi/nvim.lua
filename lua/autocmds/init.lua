local M = {}

local function copy(table)

    local ret = {}

    for k, v in pairs(table) do
        ret[k] = v
    end

    return ret

end

local function mergeTables(a, b)

    local ret = copy(a)

    for k, v in pairs(b) do
        ret[k] = v
    end

    return ret

end

local function closeBuffersList()

    local closeAutocmd = {
        "BufEnter",
        "*",
        "if (winnr('$') == 1 && &filetype == '%s') | q | endif"
    }

    local ftList = {
        _close = {
            "packer", "git-commit", "coc-explorer",
            "fugitive"
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

        vim.cmd("augroup " .. gp)
        vim.cmd("autocmd!")

        for _, defi in pairs(def) do

            vim.cmd(
                table.concat(
                    vim.tbl_flatten{"autocmd", defi}, " "
                )
            )
        end

        vim.cmd("augroup END")

end

function M.config()

    local autocmdsList = mergeTables(
        closeBuffersList(),
        require('autocmds.autocmds').setup()
    )

    for gp, def in pairs(autocmdsList) do
        setAutocmd(gp, def)
    end

end

M.config()

return M
