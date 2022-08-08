local VT = {}

VT.history = {}

VT.autocmds = function()

    vim.g.autocmd({ "CursorMoved", "CursorHold", "BufEnter" }, {
        callback = function()
            local line = vim.fn.line('.') - 1
            local diag = VT.get(0, line)
            VT.clear()

            if VT.cond(0, line, diag) then
                table.insert(
                    VT.history,
                    VT.print(0, line, VT.fmt(diag))
                )
            end

        end,
        buffer = 0
    })

end

VT.print = function(buf, line, content)
    local ns = vim.api.nvim_create_namespace(buf .. line)

    local col = string.len(vim.api.nvim_buf_get_lines(
        buf, line, line + 1, false
    )[1])

    local ext = vim.api.nvim_buf_set_extmark(
        buf, ns, line, col, { virt_text = content }
    )

    return {
        buf = buf,
        ns = ns,
        ext = ext
    }
end

VT.get = function(buf, line)
    return vim.diagnostic.get(buf, {
        lnum = line,
        severity = { max = vim.diagnostic.severity.WARN }
    })
end

VT.clear = function()
    for _, v in pairs(VT.history) do
        vim.api.nvim_buf_del_extmark(v.buf, v.ns, v.ext)
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
            (c == 1 and vim.func.str_repeat(" ", 4) or "") .. vim.icons.diagnostics,
            "Diagnostic" .. colors[di.severity]
        })
    end

    table.insert(
        content,
        { " " .. diagnostics[1].message, "Diagnostic" .. colors[max] }
    )

    return content
end

VT.cond = function(buf, line, diagnostics)
    -- Je vérifie qu'un diagnostic superieur n'est pas déjà affiché
    -- et qu'un diagnostic non affiché à été trouvé.
    return #vim.diagnostic.get(buf, {
        lnum = line,
        severity = vim.diagnostic.severity.ERROR
    }) == 0 and #diagnostics > 0
end

return VT
