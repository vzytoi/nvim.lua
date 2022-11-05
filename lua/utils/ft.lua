local FT = {}

local alias = {
    TelescopePrompt = "Telescope",
    NvimTree = "NvimTree",
    toggleterm = "zsh",
    DiffviewFilePannel = "Diff",
}

FT.disabled = {
    lualine = {
        "TelescopePrompt", "NvimTree", "toggleterm",
        "harpoon", "spectre_panel", "lspsagafinder",
        "RunCode", "qf"
    },
    ln = {
        "fugitive", "RunCode", "help", "toggleterm",
        "TelescopePrompt", "NvimTree", "harpoon",
        "sagarename", "mason.nvim", "packer", "gitcommit"
    },
    spell = {
        "toggleterm", "RunCode"
    },
    winbar = {
        "RunCode", "toggleterm"
    }
}

FT.is_disabled = function(package, bufnr)

    bufnr = bufnr or vim.fn.bufnr()

    local packagelst = FT.disabled[package]
    local ft = u.fun.buf('filetype', bufnr)

    if not packagelst then
        return false
    end

    return vim.tbl_contains(packagelst, ft)
end

FT.get_alias = function(bufnr)
    return alias[u.fun.buf('filetype', bufnr)]
end

return FT
