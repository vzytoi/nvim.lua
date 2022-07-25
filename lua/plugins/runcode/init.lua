local M = {}

local ls = require('plugins.runcode.lang')
local fn = require('fn')

local ignore_dirs = {
    os.getenv("HOME") .. '/.config/nvim'
}

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

local function command(lang)

    local rgx = {
        ["#"] = "%:p",
        ["@"] = "%:t:r"
    }

    local r = ls[lang]

    for k, v in pairs(r) do

        for target, p in pairs(rgx) do
            r[k] = r[k]:gsub(target, vim.fn.expand(p))
        end

    end

    return r

end

local function add(content, start)

    vim.api.nvim_buf_set_lines(
        vim.api.nvim_get_current_buf(),
        start, -1, false,
        content
    )

end

local function openbuf(d)

    local dirs = {
        s = "bo new"
    }

    vim.api.nvim_command(dirs[d])

end

local function run(d)

    for _, value in ipairs(ignore_dirs) do
        if string.find(vim.fn.getcwd(), value) then
            print('RunCode: This directory has been ignored')
            return
        end
    end

    if not ls[vim.bo.filetype] then
        print('RunCode: language not supported')
        return
    end

    if vim.g.rcbufnr ~= nil then
        fn.close(vim.g.rcbufnr)
    end

    local cmd = command(vim.bo.filetype)
    local fn = vim.fn.expand('%:t')

    openbuf(d)
    add({ "output of: " .. fn, "" }, 0)

    vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data then
                add(data, -1)
            end
        end,
        on_stderr = function(_, data)
            if data then
                add(data, -1)
            end
        end
    })

    vim.g.rcbufnr = vim.fn.bufnr()

    require('opts').buffer("RunCode")
    resize(d)

end

function M.setup()

    local map = require('mappings').map

    map("n")("<leader>x", function()
        run("s")
    end)

end

function M.autocmds()

    local autocmd = vim.api.nvim_create_autocmd
    local map = require('mappings').map

    autocmd("FileType", {
        pattern = "RunCode",
        callback = function()
            map()({ "<cr>", "q" }, function()
                vim.api.nvim_command('silent! bd!')

                if vim.g.rcbufnr ~= nil then
                    vim.g.rcbufnr = nil
                end

            end)
        end
    })

end

return M
