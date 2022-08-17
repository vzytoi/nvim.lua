-- @author Cyprien Henner
local VT = {}

local ns = vim.api.nvim_create_namespace("VT")

-- @description permet d'afficher du text virtuel sur le buffer courrant
-- avec comme argument le numéro de la ligne et le contenu.
VT.print = function(ln, content)

    -- j'affiche le vt après le contenue déjà présent
    -- sur la ligne.
    local col = string.len(vim.api.nvim_buf_get_lines(
        0, ln, ln + 1, false
    )[1])

    -- TODO: see :h nvim_buf_set_extmark for more options
    vim.api.nvim_buf_set_extmark(0, ns, ln, col, {
        virt_text = VT.fmt(content)
    })

end

-- @description récupère tous les diagnostics présent
-- sur le buffer courrant à une ligne donné.
VT.get = function(ln)
    return vim.diagnostic.get(0, {
        lnum = ln,
        severity = { max = vim.diagnostic.severity.WARN }
    })
end

-- @description permet d'enlever tous les text virtuel
-- présent dans le buffer courant apparenants au namespace ns.
VT.clear = function()
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

-- @description permet de formatter une lsite de dictionnaire de diagnostics
-- en une chaine de caractère qui sera ensuite affiché sous la forme
-- de text virtuel. Gère l'affichage de plusieurs dignostics sur la même ligne.
VT.fmt = function(diagnostics)
    local colors = {
        "Error",
        "Warn",
        "Info",
        "Hint"
    }

    local content = {}

    -- si pleusieurs diagnostic sur la même ln
    -- alors la couleur est celle du diag avec la sévérité
    -- la plue élevée.
    local max

    for c, di in pairs(diagnostics) do
        if max == nil or di.severity >= max then
            max = di.severity
        end

        table.insert(content, {
            string.rep(c == 1 and " " or "", 4) .. vim.icons.diagnostics,
            "Diagnostic" .. colors[di.severity]
        })
    end

    table.insert(
        content,
        { " " .. diagnostics[1].message, "Diagnostic" .. colors[max] }
    )

    return content
end

-- @description permet de vérifier si la ligne est disponible
-- pour l'affichage d'un disagnostic. Si un diagnostic est déjà
-- présent sur cette ligne ou que aucun diagnostic n'est à affiché alors
-- la ligne n'est pas disponible à l'affichage d'un diagnostic supplémentaire.
VT.cond = function(ln)
    return #vim.diagnostic.get(0, {
        lnum = ln,
        severity = vim.diagnostic.severity.ERROR
    }) == 0 and #VT.get(ln) > 0
end

VT.autocmds = function()

    vim.g.autocmd({ "CursorMoved", "CursorHold", "BufEnter" }, {
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
