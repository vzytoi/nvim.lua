local TL = {}

local devicons = require('nvim-web-devicons')

local ic = 0

local getbufnr = function(v)
    return vim.fn.tabpagebuflist(v)[
        vim.fn.tabpagewinnr(v)
        ]
end

local getft = function(bufnr)
    return vim.fn.getbufvar(bufnr, "&filetype")
end

local getfn = function(bufnr)
    return vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':t')
end

vim.cmd [[
    function! Close(minwid, clicks, button, modifiers) abort
    endfunction
]]

TL.components = {

    icon = function(bufnr)

        local ft = getft(bufnr)
        local fn = getfn(bufnr)

        local icon, color = devicons.get_icon_color(fn, ft, { default = false })

        if not icon then
            icon = vim.icons[ft] or vim.icons.file
            color = vim.colors.get().lightgrey
        end

        ic = ic + 1
        vim.cmd("hi Icon" .. ic .. " guifg=" .. color)

        return icon, "%#Icon" .. ic .. "#"
    end,

    filename = function(bufnr)

        local tab_name = {
            toggleterm = "zsh",
            NvimTree = "NvimTree",
        }

        local bn = vim.fn.bufname(bufnr)
        local ft = getft(bufnr)

        for k, v in pairs(tab_name) do
            if ft == k then
                return v
            end
        end

        return bn == "" and "Empty" or getfn(bufnr)
    end,

    color = {
        sep = function(v)

            local diags = vim.diagnostic.get(getbufnr(v), {
                severity = { min = vim.diagnostic.severity.WARN }
            })

            local severities = {
                "Error",
                "Warn"
            }

            if #diags > 0 then
                return "%#Diagnostic" .. severities[diags[1].severity] .. "#"
            end

            return "%#Sep" .. (v == vim.fn.tabpagenr() and "On#" or "Off#")

        end,
        txt = function(v)
            return "%#Text" .. (v == vim.fn.tabpagenr() and "On#" or "Off#")
        end
    }

}

TL.get = function()

    local rangetabs = vim.fn.range(
        1, vim.fn.tabpagenr('$')
    )

    local tabs = {}

    for _, v in pairs(rangetabs) do

        local tab = ""

        tab = tab .. string.format(
            "%%%dT%s",
            v, v == vim.fn.tabpagenr() and '%#TabLineSel#' or '%#TabLine#'
        )

        local bufnr = getbufnr(v)
        local icon, color = TL.components.icon(bufnr)

        local modified = vim.fn.getbufvar(bufnr, "&mod") == 1

        tab = tab ..
            TL.components.color.sep(v) ..
            "▎   " ..
            color ..
            icon ..
            "  " ..
            TL.components.color.txt(v) ..
            TL.components.filename(bufnr) ..
            "   " ..
            (modified and vim.icons.modified or "%42@Close@%X") ..
            "    "

        table.insert(tabs, tab)

    end

    return table.concat(tabs, "")

end

TL.autocmds = function()

    local tabline = require('core.tabline')

    vim.g.autocmd({ "BufEnter", "TextChanged", "TextChangedI", "CursorHold" }, {
        callback = function()
            vim.api.nvim_set_option_value(
                "tabline", tabline.get(), { scope = "local" }
            )
        end
    })

end

return TL
