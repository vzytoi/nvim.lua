local M = {}

local function scandir(directory)

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

local function on_attach(client, bufnr)

    vim.g.nmap("gr", function() vim.lsp.buf.rename() end)
    vim.g.nmap("gh", function() vim.lsp.buf.hover() end)
    vim.g.nmap("gd", function() vim.lsp.buf.definition() end)
    vim.g.nmap("gR", function() vim.lsp.buf.references() end)
    vim.g.nmap("gn", function() vim.lsp.diagnostic.goto_next() end)
    vim.g.nmap("gp", function() vim.lsp.diagnostic.goto_prev() end)
    vim.g.nmap("gs", function() vim.diagnostic.show() end)

    local grp = vim.api.nvim_create_augroup("lsp_document_format", { clear = true })
    local autocmd = vim.api.nvim_create_autocmd

    if client.supports_method("textDocument/formatting") then
        autocmd("BufWritePre", {
            callback = function() vim.lsp.buf.format() end,
            group = grp
        })
    else
        autocmd("BufWritePost", {
            callback = function() vim.api.nvim_command('FormatWrite') end,
            group = grp
        })
    end

end

M.autocmds = function()

    vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
            vim.lsp.buf.document_highlight()
        end
    })

    vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function()
            vim.lsp.buf.clear_references()
        end
    })

end

local setup = {
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

    local servers = scandir(vim.fn.stdpath('data') .. '/lsp_servers/')

    require('nvim-lsp-installer').setup {
        ensure_installed = servers,
        automatic_installation = true
    }

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

    --[[ vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
    ) ]]

    local capabilities = require("cmp_nvim_lsp").update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )

    for _, lsp in pairs(servers) do

        local s = setup[lsp]

        if s == nil then
            s = {}
        end

        require("lspconfig")[lsp].setup(
            vim.tbl_extend('keep', s, {
                on_attach = on_attach,
                capabilities = capabilities,
                root_dir = vim.loop.cwd
            })
        )
    end
end

return M
