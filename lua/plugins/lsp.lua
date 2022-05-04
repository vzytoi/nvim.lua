local M = {}

local on_attach = function(client, bufnr)
    local opts = {noremap = true, silent = true}

    local map = {
        {"gr", "<cmd>lua vim.lsp.buf.rename()<cr>"}
    }

    for _, m in pairs(map) do
        vim.api.nvim_buf_set_keymap(bufnr, "n", m[1], m[2], opts)
    end
end

M.setup = {
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT"
                },
                diagnostics = {
                    globals = {"vim"}
                }
            }
        }
    },
    tsserver = {
        on_attach = on_attach
    },
    jedi_language_server = {},
    intelephense = {}
}

M.config = function()
    local servers = {"tsserver", "sumneko_lua", "jedi_language_server", "intelephense"}

    for _, lsp in pairs(servers) do
        require("lspconfig")[lsp].setup(M.setup[lsp])
    end
end

return M
