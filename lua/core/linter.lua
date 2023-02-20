local M = {}

local get_installed_linters = function()
    local packages = require('mason-registry').get_installed_packages()
    local list = {}

    for _, v in ipairs(packages) do
        if vim.tbl_contains(v.spec.categories, "Linter") then
            list[v.spec.name] = vim.tbl_map(function(m)
                return string.lower(m)
            end, v.spec.languages)
        end
    end

    return list
end

M.linters = get_installed_linters()


M.autocmds = function()
    vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
        callback = function()
            if M.get() then
                require("lint").try_lint()
            end
        end,
    })
end

M.config = function()
    local luacheck = require('lint.linters.luacheck')

    luacheck.args = {
        '--globals',
        'u',
        'nvim',
        'vim',
        '--formatter',
        'plain',
        '--codes',
        '--ranges',
        '-',
    }

    local linters = {}
    local lint = require('lint')

    for k, v in pairs(M.linters) do
        for _, lang in ipairs(v) do
            linters[lang] = { k }
        end
    end

    lint.linters_by_ft = linters
end

M.get = function(ft)
    ft = ft or u.fun.buf('filetype')

    for k, v in pairs(M.linters) do
        if vim.tbl_contains(v, ft) then
            return k
        end
    end

    return false
end


return M
