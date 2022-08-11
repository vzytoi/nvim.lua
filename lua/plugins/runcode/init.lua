local M = {}

local ls = require('plugins.runcode.commands')

local function resize_win(bufnr, dir)

    if vim.bo.filetype ~= "RunCode" then
        return
    end

    local size = (function()
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        if dir == "s" then
            return #lines
        else
            local m

            for _, v in ipairs(lines) do
                if not m or m < #v then
                    m = #v
                end
            end

            return m
        end
    end)()

    vim.api.nvim_command(string.format(
        "%s res %s", dir == "v" and "vert" or "", size
    ))

end

local function is_open()

    local bufs = vim.func.buflst()

    for _, buf in ipairs(bufs) do
        if vim.func.buf(buf, 'filetype') == 'RunCode' then
            return buf
        end
    end

    return false

end

local function openbuf(dir)

    local commands = {
        s = "bo new",
        v = "vnew",
        t = "tabnew"
    }

    vim.api.nvim_command(
        commands[dir]
    )

    return vim.fn.bufnr()

end

local function run(dir)

    vim.g.target = vim.tbl_extend("keep",
        vim.func.buf(vim.fn.bufnr()),
        { winhandler = vim.api.nvim_get_current_win() }
    )

    local rc_bufnr = is_open()

    if rc_bufnr then
        vim.api.nvim_buf_set_lines(rc_bufnr, 0, -1, true, {})
    else
        rc_bufnr = openbuf(dir)
    end

    local error

    vim.fn.jobstart(ls.get(vim.g.target.bufnr), {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(
                    rc_bufnr, -1, -1, true, data
                )
            end
        end,
        on_stderr = function(_, data)
            if data and string.len(table.concat(data, "")) > 0 then
                vim.api.nvim_buf_set_lines(
                    rc_bufnr, -1, -1, true, data
                )
                print(vim.inspect(data))
                error = true
            end
        end,
        on_exit = function()
            vim.g.opts.buffer("RunCode")
            resize_win(rc_bufnr, dir)
        end
    })

    vim.api.nvim_buf_set_lines(rc_bufnr, 1, 1, true, { "  => Output of: " .. vim.g.target.filename, "" })
    vim.api.nvim_buf_add_highlight(rc_bufnr, -1, error ~= nil and "RunCodeError" or "RunCodeOk", 1, 0, -1)

end

function M.keymaps()

    vim.g.nmap("<leader>x", function()
        run("s")
    end)

    vim.g.nmap("<leader>xv", function()
        run("v")
    end)

    vim.g.nmap("<leader>xt", function()
        run("t")
    end)

end

function M.autocmds()

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "RunCode",
        callback = function()
            vim.g.nmap({ "<cr>", "q" }, function()
                vim.func.close(vim.fn.bufnr())
                vim.api.nvim_set_current_win(
                    vim.g.target.winhandler
                )
            end, { buffer = 0 })
        end
    })

    vim.api.nvim_create_autocmd("BufWinLeave", {
        pattern = "RunCode",
        callback = function()
            vim.api.nvim_set_current_win(
                vim.g.target.winhandler
            )
        end
    })

end

return M
