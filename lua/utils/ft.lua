local FT = {}

local filetypes = {
    TelescopePrompt = {
        alias = "Telescope",
        disable = { 'lualine' }
    },
    NvimTree = {
        alias = "NvimTree",
        disable = { 'lualine' }
    },
    toggleterm = {
        alias = "zsh",
        disable = { 'lualine' }
    },
    DiffviewFilePannel = { alias = "Diff" },
    harpoon = { disable = { 'lualine' } },
    spectre_panel = { disable = { 'lualine' } },
    lspsagafinder = { disable = { 'lualine' } }
}

FT.get = function(bufnr)
    -- bufnr = bufnr or vim.fn.bufnr()
    return filetypes[vim.func.buf('filetype', bufnr)] or {}
end

-- permet de retourner si un buffer est désactivé
-- c'est à dire que le le package est désactivé pour un
-- buffer donné (lualine, tabline...)
FT.is_disabled = function(package)

    local opts = FT.get()
    return (opts.disable and vim.tbl_contains(opts.disable, package))

end

FT.get_alias = function(bufnr)
    local opts = FT.get(bufnr)

    return opts.alias
end

return FT
