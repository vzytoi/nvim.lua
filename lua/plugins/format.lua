local M = {}

local fmt = require('formatter')
local util = require "formatter.util"

local formatters = {

    python = {
        function()
            return {
                exe = "black",
                args = { "-q", "--fast", "-" },
                stdin = true,
            }
        end
    },
    ocaml = {
        function()
            return {
                exe = "ocamlformat",
                args = {
                    "--enable-outside-detected-project",
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
