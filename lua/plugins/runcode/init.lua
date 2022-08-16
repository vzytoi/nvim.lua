local M = {}

local ls = require('plugins.runcode.commands')

local write = {
    clear = function(nr)
        vim.api.nvim_buf_set_lines(nr, 0, -1, true, {})
    end,
    append = function(nr, data, l, hl)

        data = (type(data) == "table" and data or { data })
        vim.api.nvim_buf_set_lines(nr, l, l, true, data)

        if hl then
            vim.api.nvim_buf_add_highlight(nr, -1, hl, l, 0, -1)
        end
    end,
}

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
        { view = vim.fn.winsaveview() }
    )

    local rc_bufnr = is_open()

    if rc_bufnr then
        write.clear(rc_bufnr)
    else
        rc_bufnr = openbuf(dir)
    end

    local error = false

    vim.fn.jobstart(ls.get(vim.g.target.bufnr), {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data then
                write.append(rc_bufnr, data, -1)
            end
        end,
        on_stderr = function(_, data)
            if data then
                write.append(rc_bufnr, data, -1)
                error = true
            end
        end,
        on_exit = function()

            write.append(
                rc_bufnr, { "  => Output of: " .. vim.g.target.filename }, 0,
                "RunCode" .. (error and "Error" or "Ok")
            )

            vim.g.opts.buffer("RunCode")
            resize_win(rc_bufnr, dir)
        end
    })

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
                vim.fn.winrestview(vim.g.target.view)
            end, { buffer = 0 })
        end
    })

    vim.api.nvim_create_autocmd("BufWinLeave", {
        pattern = "RunCode",
        callback = function()
            vim.fn.winrestview(vim.g.target.view)
        end
    })

end

return M
