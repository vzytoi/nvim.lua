local M = {}

local fmt = require "formatter"
local util = require "formatter.util"

local formatters = {
    python = {
        function()
            if vim.fn.getfsize(vim.fn.expand('%')) <= 1 then
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
                    "--function-indent=2",
                    "--extension-indent=2",
                    "--indent-after-in=2",
                    "--let-binding-indent=2",
                    "--match-indent=2",
                    "--match-indent-nested=always",
                    "--cases-exp-indent=2",
                    "--break-separator=before",
                    "--space-around-records",
                    "--space-around-lists",
                    "--space-around-arrays",
                    "--indicate-nested-or-patterns=unsafe-no",
                    "--wrap-comments",
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
    if not (fmt and formatters) then
        return
    end

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
