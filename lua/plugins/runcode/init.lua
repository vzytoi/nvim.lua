local M = {}

local ls = require('plugins.runcode.lang')

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

local function add(bufnr, content, start)

    vim.api.nvim_buf_set_lines(
        bufnr or vim.api.nvim_get_current_buf(),
        start, -1, false,
        content
    )

end

local function openbuf(d)

    local dirs = {
        s = "bo new",
        v = "vnew"
    }

    vim.api.nvim_command(dirs[d])

    return vim.fn.bufnr()

end

local function run(d)

    for _, value in ipairs(ignore_dirs) do
        if string.find(vim.fn.getcwd(), value) then
            require('notify')("This directory has been ignored", "ERROR", { title = "RunCode" })
            return
        end
    end

    if not ls[vim.bo.filetype] then
        require('notify')("Filetype isn't supported", "ERROR", { title = "RunCode" })
        return
    end

    local cmd = command(vim.bo.filetype)
    local fn = vim.func.getfn()

    if not vim.g.rcbufnr then
        vim.g.rcbufnr = openbuf(d)
    else
        add(vim.g.rcbufnr, {}, 0)
    end

    add(vim.g.rcbufnr, { " => Output of: " .. fn, "" }, 0)

    vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data then
                add(vim.g.rcbufnr, data, -1)
            end
        end,
        on_stderr = function(_, data)
            if data then
                add(vim.g.rcbufnr, data, -1)
            end
        end
    })

    vim.g.opts.buffer("RunCode")
    resize(d)

end

function M.keymaps()

    vim.g.nmap("<leader>x", function()
        run("s")
    end)

    vim.g.nmap("<leader>xv", function()
        run("v")
    end)

end

function M.autocmds()

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "RunCode",
        callback = function()
            vim.g.nmap({ "<cr>", "q" }, function()
                if vim.g.rcbufnr then
                    vim.func.close(vim.fn.bufnr())
                    vim.g.rcbufnr = nil
                end

            end)
        end
    })

end

return M
