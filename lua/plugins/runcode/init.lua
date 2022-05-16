local M = {}

local lang = require("plugins.runcode.lang")

function M.setup()
    vim.g.called2 = true

    vim.keymap.set("n", "<leader>x",
        function()
        M.run("x")
    end)

    vim.keymap.set("n", "<leader>xs",
        function()
        M.run("s")
    end)

    vim.keymap.set("n", "<leader>xv",
        function()
        M.run("v")
    end)

    vim.keymap.set("n", "<leader>xe",
        function()
        M.time()
    end)

end

function M.command()
    local c = lang[vim.bo.filetype]

    local changes = {
        n = {
            ["#"] = "%:t",
            ["@"] = "%:t:r"
        }
    }

    for k, v in pairs(changes[vim.fn.mode()]) do
        c = c:gsub(k, vim.fn.expand(v))
    end

    return c
end

function M.run(dir)
    local d = {
        s = "split_f|r !",
        v = "vnew|r !",
        x = "!"
    }

    vim.cmd(d[dir] .. "echo '' && " .. M.command())

    if dir ~= "x" then
        require("options").setBufferOpts()
        M.resize(dir)
    end
end

function M.resize(dir)
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

function M.time()
    vim.api.nvim_command(string.format("!time %s", M.command()))
end

return M
