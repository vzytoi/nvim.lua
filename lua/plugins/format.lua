local M = {}

local fmt = require "formatter"
local util = require "formatter.util"
local linter = require "core.linter"

local formatters = {

    python = {
        function()

            if vim.fn.getfsize(vim.fn.expand('%')) <= 1 then
                return nil
            end

            -- seule solution trouvée pour l'instant pour pas avoir
            -- d'erreurs de formattage
            local diag = vim.diagnostic.get(0)
            local is_linter = true

            for _, din in pairs(diag) do
                if din.source ~= linter.get() then
                    is_linter = false
                end
            end

            if not vim.tbl_isempty(diag) and not is_linter then
                return nil
            end

            return {
                exe = "black",
                args = { "--line-length=60", "-q", "--fast", "-" },
                stdin = true,
            }
        end
    },
    ocaml = {
        function()

            if vim.fn.getfsize(vim.fn.expand('%')) <= 1 then
                return nil
            end

            return {
                exe = "ocamlformat",
                args = {
                    "--enable-outside-detected-project",
                    "--break-cases=toplevel",
                    "--break-collection-expressions=wrap",

                    "--if-then-else=k-r",

                    "--function-indent=4",
                    "--extension-indent=4",
                    "--indent-after-in=4",
                    "--let-binding-indent=4",
                    "--match-indent=4",
                    "--match-indent-nested=always",
                    "--cases-exp-indent=4",

                    "-q",
                    "--name",
                    util.escape_path(util.get_current_buffer_file_name()),
                    "-"
                },
                stdin = true,
            }
        end
    }
}

M.config = function()

    fmt.setup({
        filetype = formatters
    })

end

M.get = function(ft)
    return vim.tbl_contains(
        vim.tbl_keys(formatters), ft
    )
end

return M
