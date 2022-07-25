local M = {}

local lang = require("plugins.runcode.lang")

local ignore_dirs = {
    os.getenv("HOME") .. '/.config/nvim'
}

local function command()
    local c = lang[vim.bo.filetype]

    local changes = {
        n = {
            ["#"] = "%:p",
            ["@"] = "%:t:r"
        }
    }

    for k, v in pairs(changes[vim.fn.mode()]) do
        c = c:gsub(k, vim.fn.expand(v))
    end

    return c
end

local function resize(dir)
    local lines = vim.fn.getline(1, "$")
    local m = 0

    if dir == "s" then
        m = #lines
    else
        for _, v in pairs(lines) do
            if string.len(v) > m then
                m = string.len(v)
            end
        end
        if m > 150 then
            m = 75
        end
    end

    local sd = ""
    if dir == "v" then
        sd = "vert"
    end

    vim.api.nvim_command(string.format("%s res %s", sd, m + 10))
end

local function run(dir)

    for _, value in ipairs(ignore_dirs) do
        if string.find(vim.fn.getcwd(), value) then
            print('RunCode: This directory has been ignored')
            return
        end
    end

    local d = {
        s = "bo split_f|r !",
        v = "vnew|r !"
    }

    vim.cmd(d[dir] .. command())

    require('opts').setBufferOpts()
    resize(dir)

end

local function time()
    vim.api.nvim_command(string.format("!time %s", command()))
end

function M.setup()

    local map = require('mappings').map

    map("n")("<leader>x", function()
        run("s")
    end)

    map("n")("<leader>xv", function()
        run("v")
    end)

    map("n")("<leader>xe", function()
        time()
    end)

end

function M.autocmds()
    vim.cmd("autocmd FileType runcode nnoremap <buffer> <cr> :silent q!<cr>")
end

return M
