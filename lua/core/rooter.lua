local ROOT = {}

local options = {
    history_path = vim.fn.stdpath('data') .. '/rooter/history',
    -- liste des fichiers, qui s'ils sont comptenus dans un dossier
    -- alors celui-ci est considéré comme root.
    targets = { '.git', '.gitignore', 'README.md' }
}

local write = function(path)
    vim.fn.writefile({ path }, options.history_path, "a")
end

local read = function()
    return vim.fn.readfile(options.history_path)
end

-- @usage permet de trouver le fichier root d'un projet
-- selon plusieurs méthode, soit le chemin est enregistré
-- ou alors trouvé avec les fichiers qu'il contient. Si aucun
-- dossier root n'est trouvé alors il est demandé.
-- @param add -> bool: si false alors seule la verifications
-- sur les roots déjà enregistrés est effectué.
ROOT.search_root = function(add)

    -- unwanted(bufnr, {}fts or nil)
    -- check if has fn, is modifable...
    if vim.func.unwanted(vim.fn.bufnr()) then
        return
    end

    local path = vim.fs.normalize(
        vim.fn.expand('%:p:h')
    )

    for parent, _ in vim.fs.parents(path) do

        -- si un chemin déjà enregistré est trouvé alors
        -- je cd et je return
        if vim.tbl_contains(read(), parent) then
            vim.cmd.cd(parent)
            return
        end
        if not add then
            goto continuel1
        end

        for name, _ in vim.fs.dir(parent) do

            if vim.tbl_contains(options.targets, name) then
                if vim.fn.input(parent .. " ? y/n ") == "y" then

                    vim.cmd.cd(write(parent))

                    return
                else
                    -- si le path est refusé sur l'un des fichiers
                    -- alors je passe la potentielle sur-proposition
                    -- lors de la détection des autre fichiers du même dossier
                    goto continuel1
                end
            end

        end

        ::continuel1::
    end

    if add then
        -- en cas de recherche échouée si add est true
        -- alors je demande à l'utilisateur le dossier racine.
        -- TODO: vérifié que le chemin donné est valid.
        vim.cmd.cd(write(vim.fn.input("", path)))
    else
        -- si rien n'est trouvé je retourne quand meme
        -- dans le dossier parent...
        vim.cmd.cd(path)
    end

end

ROOT.keymaps = function()

    vim.g.nmap("<leader>cd", function()
        require('core.rooter').search_root(true)
    end)

end

ROOT.autocmds = function()

    vim.g.autocmd({ "DirChanged", "BufEnter" }, {
        callback = function()
            -- je ne veux pas être input() sur un autocmd.
            -- (contrairement à <leader>cd)
            require('core.rooter').search_root(false)
        end
    })

end

return ROOT
