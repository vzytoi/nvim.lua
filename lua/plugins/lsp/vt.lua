local VT = {}

local ns = nvim.create_namespace("VT")

VT.print = function(ln, content)

    local line_content = nvim.buf_get_lines(
        0, ln, ln + 1, false
    )

    if not line_content then
        return
    end

    local col = string.len(table.concat(line_content, ''))

    nvim.buf_set_extmark(0, ns, ln, col, {
        virt_text = VT.fmt(content)
    })

end

VT.get = function(ln)
    return vim.diagnostic.get(0, {
        lnum = ln,
        severity = { max = vim.diagnostic.severity.WARN }
    })
end

VT.clear = function()
    for _, bufnr in ipairs(u.fun.buflst()) do
        nvim.buf_clear_namespace(bufnr, ns, 0, -1)
    end
end

VT.fmt = function(diagnostics)
    local colors = {
        "Error",
        "Warn",
        "Info",
        "Hint"
    }

    local content = {}
    local max

    for c, di in pairs(diagnostics) do

        if max == nil or di.severity >= max then
            max = di.severity
        end

        table.insert(content, {
            string.rep(c == 1 and " " or "", 4) .. u.icons.diagnostics,
            "Diagnostic" .. colors[di.severity]
        })
    end

    table.insert(
        content,
        { " " .. diagnostics[1].message, "Diagnostic" .. colors[max] }
    )

    return content
end

VT.cond = function(ln)
    return #vim.diagnostic.get(0, {
        lnum = ln,
        severity = vim.diagnostic.severity.ERROR
    }) == 0 and #VT.get(ln) > 0
end

VT.autocmds = function()

    vim.g.autocmd({ "CursorMoved" }, {
        callback = function()
            local ln = vim.fn.line('.') - 1
            VT.clear()
            if VT.cond(ln) then
                VT.print(ln, VT.get(ln))
            end

        end,
        buffer = 0
    })

end

return VT
