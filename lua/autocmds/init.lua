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
        "BufEnter", "if (winnr('$') == 1 && &filetype == '%s') | q | endif"
    }

    local ftList = {
        _close = {"packer", "git-commit", "coc-explorer"}
    }

    local current

    for k, v in ipairs(ftList['_close']) do

        current = closeAutocmd

        current[2] = string.format(
            current[2], v
        )

        ftList['_close'][k] = current

    end

    return ftList

end

local function setAutocmd(gp, def)

        vim.cmd("augroup " .. gp)
        vim.cmd("autocmd!")

        for _, defi in pairs(def) do

            if #defi <= 2 then
                defi = {defi[1], "*", defi[2]}
            end

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
        require('autocmds.autocmds')
    )

    for gp, def in pairs(autocmdsList) do
        setAutocmd(gp, def)
    end

end

M.config()

return M
