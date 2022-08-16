local FT = {}

local filetypes = {
    toggleterm = { alias = "zsh" },
    TelescopePrompt = { alias = "Telescope" },
    DiffviewFilePannel = { alias = "Diff" },
    NvimTree = { alias = "NvimTree" },
    harpoon = { disable = { 'lualine' } },
    spectre_panel = { disable = { 'lualine' } },
    lspsagafinder = { disable = { 'lualine' } }
}

--[[ FT.get_alias = function(bufnr)

    local vim.api.nvim_buf_get_var(bufnr, 'ftopts')
end
]]

FT.is_disabled = function(bufnr, package)

    if not vim.api.nvim_buf_get_option(bufnr, 'modifiable') or
        vim.fn.bufname(bufnr) == "" then
        return true
    end

    local opts = vim.api.nvim_buf_get_var(bufnr, 'ftopts')
    if opts.disable and vim.tbl_contains(opts.disable, package) then
        return true
    end

    return false

end

FT.autocmds = function()
    vim.g.autocmd("BufEnter", {
        callback = function()
            vim.api.nvim_buf_set_var(
                0, 'ftopts', filetypes[vim.bo.ft] or {}
            )
        end
    })
end

return FT
