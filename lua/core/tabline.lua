local TL = {}

local devicons = require('nvim-web-devicons')

local get_bufnr = function(v)
    return vim.fn.tabpagebuflist(v)[
        vim.fn.tabpagewinnr(v)
        ]
end

vim.cmd [[
    function! Close(minwid, clicks, button, modifiers) abort
    endfunction
]]

local components = {

    -- @description permet de récupérer l'icon avec sa
    -- couleur associé à un bufnr donné en argument.
    -- Si aucun icon n'est trouvé dans nvim-web-devicons
    -- alors un icon dans vim.icons est récupéré.
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

    -- @description permet de récupérer le nom associé au
    -- bufnr donné. Un alias est cherché, une valeur par défaut
    -- est générée si aucun nom n'est trouvé,
    -- sinon le filename est retourné.
    filename = function(bufnr)

        local alias = vim.ft.get_alias(bufnr)

        if alias then
            return alias
        end

        if vim.func.is_empty(vim.fn.bufname(bufnr)) then
            return "Empty"
        end

        return vim.func.buf('filename', bufnr)
    end,

    -- @description retourne un icon modified si le bufnr est
    -- modifié, sinon retourne un croix qui permet de fermé la
    -- tab. Pour cela une fonction Close() est exécutée.
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
