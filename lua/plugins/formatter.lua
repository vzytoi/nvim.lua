local M = {}

M.setup = {
    python = {
        function()
            return {
                exe = "python3 -m autopep8",
                args = {
                    "--in-place --aggressive --aggressive"
                },
                stdin = false
            }
        end
    }
}

M.config = function()

    require("formatter").setup {
        logging = false,
        filetype = M.setup
    }

end

return M
