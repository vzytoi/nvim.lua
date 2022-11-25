local M = {}

local ls = require('plugins.runcode.commands')

local write = {
    clear = function(nr)
        nvim.buf_set_lines(nr, 0, -1, true, {})
    end,
    lines = function(nr, data, l, hl)

        data = (type(data) == "table" and data or { data })
        nvim.buf_set_lines(nr, l, l, true, data)

        if hl then
            nvim.buf_add_highlight(nr, -1, hl, l, 0, -1)
        end
    end,
    endl = function(nr, l)
        nvim.buf_set_lines(nr, l, l, true, { "" })
    end
}

local function resize_window(bufnr, win)

    if vim.bo.filetype ~= "RunCode" then
        return
    end

    local direction = (function(winh)
        if vim.go.columns == vim.fn.winwidth(winh) then
            return "horizontal"
        elseif vim.fn.winheight(winh) + vim.go.cmdheight + 2 == vim.go.lines then
            return "vertical"
        end

        return "tab"
    end)(win)

    local size = (function(bufnrh)
        local lines = nvim.buf_get_lines(bufnrh, 0, -1, false)

        if direction == "horizontal" then
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
    end)(bufnr)

    nvim[
        "win_set_" ..
            (direction == "vertical" and "width" or "height")
        ](win, size + 10)

end

local function is_open()

    local bufs = u.fun.buflst()

    for _, buf in ipairs(bufs) do
        if u.fun.buf('filetype', buf) == 'RunCode' then
            return buf
        end
    end

    return false

end

local function prepare_buffer(direction)

    local commands = {
        s = "bo new",
        v = "vnew",
        t = "tabnew"
    }

    local bufnr = is_open()

    if bufnr then
        write.clear(bufnr)
    else
        nvim.command(
            commands[direction]
        )

        bufnr = vim.fn.bufnr()
    end

    return bufnr, nvim.get_current_win()
end

local execute = function(direction)

    vim.g.target = {
        view = vim.fn.winsaveview(),
        bufnr = vim.fn.bufnr(),
        filename = u.fun.buf('filename'),
    }

    if u.fun.toboolean(vim.fn.getbufvar(vim.fn.bufnr(), '&mod')) then
        nvim.command('noa w')
    end

    if not ls.get(vim.g.target.bufnr) then
        return
    end

    u.fun.timer_start()

    local error = false
    local output = {}

    local function add(_, data)
        if data then
            table.insert(output, data)
        end
    end

    vim.fn.jobstart(vim.fn.join(ls.get(vim.g.target.bufnr), " "), {
        stdout_buffered = true,
        on_stdout = add,
        on_stderr = function(_, data)
            if #vim.fn.join(data) > 0 then
                error = true
            end

            add(_, data)
        end,
        on_exit = function()

            local bufnr, winhandle = prepare_buffer(direction)
            local timer = u.fun.timer_end()

            write.lines(
                bufnr,
                string.format(
                    "In: %s %s | Lines: %s",
                    timer.time, timer.unit,
                    nvim.buf_line_count(vim.g.target.bufnr)
                ),
                0,
                "RunCodeInfo"
            )

            write.lines(
                bufnr,
                string.format(
                    "=> Output of: %s",
                    vim.g.target.filename
                ),
                2,
                "RunCode" .. (error and "Error" or "Ok")
            )

            write.endl(bufnr, -1)

            for _, data in ipairs(output) do
                if #vim.fn.join(data, "") ~= 0 then
                    write.lines(bufnr, data, -1)
                end
            end

            vim.g.opts.buffer("RunCode")
            resize_window(bufnr, winhandle)
        end
    })

end

M.keymaps = function()

    vim.g.nmap("<leader>x", function()
        execute("s")
    end)

    vim.g.nmap("<leader>xv", function()
        execute("v")
    end)

    vim.g.nmap("<leader>xt", function()
        execute("t")
    end)

end

M.autocmds = function()

    nvim.create_autocmd("FileType", {
        pattern = "RunCode",
        callback = function()
            vim.g.nmap({ "<cr>", "q" }, function()
                u.fun.close(vim.fn.bufnr())
                vim.fn.winrestview(vim.g.target.view)
            end, { buffer = 0 })

            local ns = nvim.create_namespace('RunCode')
            nvim.win_set_hl_ns(0, ns)

            local c = u.colors.get()

            nvim.set_hl(ns, 'Normal', { bg = c.darkerblack })
            nvim.set_hl(ns, 'EndOfBuffer', { fg = c.darkerblack })
        end
    })

    nvim.create_autocmd("BufLeave", {
        pattern = "RunCode",
        callback = function()
            vim.fn.winrestview(vim.g.target.view)
        end
    })

end

return M
