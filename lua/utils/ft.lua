local FT = {}

local alias = {
    TelescopePrompt = "Telescope",
    NvimTree = "NvimTree",
    toggleterm = "zsh",
    DiffviewFilePannel = "Diff",
    man = "Man",
    alpha = "Alpha"
}

FT.patterns = {
    ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json",
    "dune-project",
}

FT.close_when_last = {
    "toggleterm", "NvimTree", "RunCode"
}

FT.disabled = {
    lualine = {
        "TelescopePrompt", "harpoon"
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
        "RunCode", "toggleterm", "NvimTree",
        "packer", "startuptime", "harpoon"
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
