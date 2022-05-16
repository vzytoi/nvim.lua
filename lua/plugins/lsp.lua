local M = {}

local utils = require("utils")

M.lsp_keymaps = function(bufnr)
    local map = {
        { "gr", "<cmd>lua vim.lsp.buf.rename()<cr>" },
        { "gh", "<cmd>lua vim.lsp.buf.hover()<cr>" },
        { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>" },
        { "gR", "<cmd>lua vim.lsp.buf.references()<cr>" },
        { "gn", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>" },
        { "gp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>" }
    }

    for _, m in pairs(map) do
        vim.api.nvim_buf_set_keymap(bufnr, "n", m[1], m[2], utils.opts)
    end
end

M.on_attach = function(_, bufnr)
    M.lsp_keymaps(bufnr)

    require("autocmds").lsp_highlight()
end

M.setup = {
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT"
                },
                diagnostics = {
                    globals = { "vim" }
                },
                workspaces = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.stdpath("config") .. "/lua"] = true
                    }
                }
            }
        }
    }
}

M.config = function()
    vim.diagnostic.config({
        virtual_text = true,
        underline = false,
        update_in_insert = false,
        severity_sort = true,
        float = {
            source = "always",
            border = "rounded"
        }
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
    )

    local servers = utils.scandir(vim.fn.stdpath('data') .. '/lsp_servers/')
    local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

    require("nvim-lsp-installer").setup {
        ensure_installed = servers
    }

    for _, lsp in pairs(servers) do

        local setup = M.setup[lsp]

        if setup == nil then
            setup = {}
        end

        require("lspconfig")[lsp].setup(
            utils.mergeTables(setup, {
                on_attach = M.on_attach,
                capabilities = capabilities,
                root_dir = vim.loop.cwd
            })
        )
    end
end

return M
