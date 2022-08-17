-- @author Cyprien Henner
local VT = {}

local ns = vim.api.nvim_create_namespace("VT")

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

-- @usage permet d'afficher du text virtuel sur le buffer courrant
-- en prenant uniquement en argument le nl et le comptenu.
-- @param ln: line number of virtual text
-- @param content: content to show, is passed thought @see VT.fmt()
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

-- @usage permet de vérifier si des diagnostics sont déjà
-- présent sur une ligne donnée
-- @param ln: numéro de ligne recherché
-- @return la liste des diagnostics attaché à la ligne
-- donnée en argument
VT.get = function(ln)
    return vim.diagnostic.get(0, {
        lnum = ln,
        severity = { max = vim.diagnostic.severity.WARN }
    })
end

-- @usage permet d'enlever tous les text virtuel
-- présent dans le buffer courant apparenants au namespace @see ns
VT.clear = function()
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

-- permet de formatter la liste des diagnostic
-- en un text affichable en tant que vt.

-- @usage permet de formatter une liste de dictionnaire
-- de diagnostics en un chaine de caractères affichable en vt
-- @param diagnostics [TODO:description]
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

-- @usage permet de vérifier si la ligne est disponible
-- pour l'affichage d'un disagnostic
-- @return (bool) s'il y a aucun vt déjà présent sur la ligne
-- et si il y a un diagnostic à afficher
-- @param ln -> int: numbero de ligne à verifier
VT.cond = function(ln)
    return #vim.diagnostic.get(0, {
        lnum = ln,
        severity = vim.diagnostic.severity.ERROR
    }) == 0 and #VT.get(ln) > 0
end

return VT
