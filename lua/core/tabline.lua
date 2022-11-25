local TL = {}

local devicons = require('nvim-web-devicons')
local c = u.colors.get()

local get_bufnr = function(v)
    return vim.fn.tabpagebuflist(v)[
        vim.fn.tabpagewinnr(v)
        ]
end

local components = {

    -- @description permet de récupérer l'icon avec sa
    -- couleur associé à un bufnr donné en argument.
    -- Si aucun icon n'est trouvé dans nvim-web-devicons
    -- alors un icon dans u.icons est récupéré.
    icon = function(bufnr)

        local ft = u.fun.buf('filetype', bufnr)
        local icon, color, _ = devicons.get_icon_colors_by_filetype(ft)

        if not icon then
            icon = u.icons[ft] or u.icons.file
            color = u.colors.get().lightgrey
        end

        nvim.set_hl(0, 'Icon' .. ft, { bg = c.black, fg = (color or "NONE") })

        return icon, "%#Icon" .. ft .. "#"
    end,

    -- @description permet de récupérer le nom associé au
    -- bufnr donné. Un alias est cherché, une valeur par défaut
    -- est générée si aucun nom n'est trouvé,
    -- sinon le filename est retourné.
    filename = function(bufnr)

        local alias = u.ft.get_alias(bufnr)

        if alias then
            return alias
        end

        if u.fun.is_empty(vim.fn.bufname(bufnr)) then
            return "Empty"
        end

        return u.fun.buf('filename', bufnr)
    end,

    -- @description retourne un icon modified si le bufnr est
    -- modifié, sinon retourne un croix qui permet de fermé la
    -- tab. Pour cela une fonction Close() est exécutée.
    modified = function(bufnr)

        local is_modified = u.fun.toboolean(vim.fn.getbufvar(bufnr, '&mod'))
        return "%#TabLineSel#" .. (is_modified and u.icons.modified or "%42@Close@%X")

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
        txt = function(tabnr)
            return "%#Text" .. (tabnr == vim.fn.tabpagenr() and "On#" or "Off#")
        end
    },

}

local currtab = function(tabnr)
    return tabnr == vim.fn.tabpagenr()
end

TL.get = function()

    local function s(count)
        return string.rep(" ", count)
    end

    local rangetabs = vim.fn.range(1, vim.fn.tabpagenr('$'))
    local tabs = {}

    for _, tabnr in pairs(rangetabs) do

        local tab = ""

        tab = tab .. string.format(
            "%%%dT%s",
            tabnr, tabnr == vim.fn.tabpagenr() and '%#TabLineSel#' or '%#TabLine#'
        )

        local bufnr = get_bufnr(tabnr)
        local icon, color = components.icon(bufnr)

        if not currtab(tabnr) then
            color = '%#TextOff#'
        end

        tab = tab .. table.concat({
            components.color.sep(tabnr),
            "▎",
            s(3),
            "%#TabLineSel#",
            components.color.txt(tabnr),
            components.filename(bufnr),
            s(3),
            color,
            icon,
            s(2),
            components.modified(tabnr),
            s(2)
        }, "")

        table.insert(tabs, tab)

    end

    return table.concat(tabs, "") .. "%#TabLineFill#"

end

TL.autocmds = function()

    local tabline = require('core.tabline')

    vim.g.autocmd({ "DiagnosticChanged", "BufEnter", "TextChanged", "TextChangedI", "CursorHold" }, {
        callback = function()
            nvim.set_option_value("tabline", not u.ft.is_disabled('tabline') and tabline.get() or "", { scope = "local" })
        end
    })

end

return TL
