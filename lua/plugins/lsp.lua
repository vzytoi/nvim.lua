local M = {}

M.scandir = function(directory)

    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "' .. directory .. '"')

    if pfile ~= nil then
        for filename in pfile:lines() do
            i = i + 1
            t[i] = filename
        end
        pfile:close()
    else
        return false
    end

    return vim.list_slice(t, 3, #t)
end

M.keymaps = function(bufnr)
    local map = {
        { "gr", "<cmd>lua vim.lsp.buf.rename()<cr>" },
        { "gh", "<cmd>lua vim.lsp.buf.hover()<cr>" },
        { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>" },
        { "gR", "<cmd>lua vim.lsp.buf.references()<cr>" },
        { "gn", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>" },
        { "gp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>" }
    }

    for _, m in pairs(map) do
        vim.api.nvim_buf_set_keymap(bufnr, "n", m[1], m[2], { noremap = true, silent = true})
    end
end

M.autocmds = function()
    --[[ vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
            vim.lsp.buf.document_highlight()
        end
    }) ]]

    --[[ vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function()
            vim.lsp.buf.clear_references()
        end
    }) ]]
end

M.on_attach = function(_, bufnr)
    M.keymaps(bufnr)
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
                },
                telemetry = {
                    enable = false
                }
            }
        }
    }
}

M.config = function()

    vim.diagnostic.config({
        underline = false,
        update_in_insert = false,
        severity_sort = true,
        float = {
            source = "always",
            border = "rounded"
        },
        virtual_text = {
            severity = { min = vim.diagnostic.severity.WARN }
        }
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
    )

    local servers = M.scandir(vim.fn.stdpath('data') .. '/lsp_servers/')
    local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

    require('nvim-lsp-installer').setup {
        ensure_installed = servers,
        automatic_installation = true
    }

    for _, lsp in pairs(servers) do

        local setup = M.setup[lsp]

        if setup == nil then
            setup = {}
        end

        require("lspconfig")[lsp].setup(
            vim.tbl_extend('keep', setup, {
                on_attach = M.on_attach,
                capabilities = capabilities,
                root_dir = vim.loop.cwd
            })
        )
    end
end

return M
