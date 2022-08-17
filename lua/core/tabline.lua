local TL = {}

local devicons = require('nvim-web-devicons')

local get_bufnr = function(v)
    return vim.fn.tabpagebuflist(v)[
        vim.fn.tabpagewinnr(v)
        ]
end

-- is triggered when the close icon on each tab is clicked on
-- TODO: search a way to close
vim.cmd [[
    function! Close(minwid, clicks, button, modifiers) abort
    endfunction
]]

local components = {

    icon = function(bufnr)

        local ft = vim.func.buf('filetype', bufnr)
        local icon, color, _ = devicons.get_icon_colors_by_filetype(ft)

        if not icon then
            icon = vim.icons[ft] or vim.icons.file
            color = vim.colors.get().lightgrey
        end

        vim.api.nvim_set_hl(0, 'Icon' .. ft, { fg = (color or "NONE") })

        return icon, "%#Icon" .. ft .. "#"
    end,

    filename = function(bufnr)

        local bn = vim.fn.bufname(bufnr)
        local alias = vim.ft.get_alias(bufnr)

        if alias then
            return alias
        end

        if bn == "" then
            return "Empty"
        end

        return vim.func.buf('filename', bufnr)
    end,

    modified = function(bufnr)

        local is_modified = vim.func.toboolean(vim.fn.getbufvar(bufnr, '&mod'))
        return is_modified and vim.icons.modified or "%42@Close@%X"

    end,

    color = {
        sep = function(tabnr)

            local diags = vim.diagnostic.get(get_bufnr(tabnr), {
                severity = { min = vim.diagnostic.severity.WARN }
            })

            local severities = {
                "Error",
                "Warn"
            }

            if #diags > 0 then
                return "%#Diagnostic" .. severities[diags[1].severity] .. "#"
            end

            return "%#Sep" .. (tabnr == vim.fn.tabpagenr() and "On#" or "Off#")

        end,
        txt = function(v)
            return "%#Text" .. (v == vim.fn.tabpagenr() and "On#" or "Off#")
        end
    },

}

TL.get = function()

    local function s(count)
        return string.rep(" ", count)
    end

    local rangetabs = vim.fn.range(1, vim.fn.tabpagenr('$'))
    local tabs = {}

    for _, tabnr in pairs(rangetabs) do

        local tab = ""

        -- une section nécessaire pour pouvoir
        -- différencier la tab courrente des autres pour la couleur.
        tab = tab .. string.format(
            "%%%dT%s",
            tabnr, tabnr == vim.fn.tabpagenr() and '%#TabLineSel#' or '%#TabLine#'
        )

        local bufnr = get_bufnr(tabnr)
        local icon, color = components.icon(bufnr)

        tab = table.concat({
            components.color.sep(tabnr),
            "▎",
            s(3),
            color,
            icon,
            s(3),
            components.color.txt(tabnr),
            components.filename(bufnr),
            s(3),
            components.modified(tabnr),
            s(3)
        })

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
