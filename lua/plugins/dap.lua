local M = {}

M.load = {
    "mfussenegger/nvim-dap",
    config = function()
        M.config()
    end,
    dependencies = {
        "rcarriga/nvim-dap-ui"
    }
}

M.keymaps = function()
    vim.keymap.set("n", "<leader>d", function()
        require('dapui').toggle()
    end)

    vim.keymap.set("n", "<leader>db", function()
        require('dap').toggle_breakpoint()
    end)

    vim.keymap.set("n", "<leader>dc", function()
        require('dap').continue()
    end)

    vim.keymap.set("n", "<leader>di", function()
        require('dap').step_into()
    end)

    vim.keymap.set("n", "<leader>dk", function()
        require('dap').step_over()
    end)

    vim.keymap.set("n", "<leader>dj", function()
        require('dap').step_out()
    end)
end

M.config = function()
    local dap = require('dap')
    local ui = require('dapui')

    dap.configurations.c = {
        {
            type = 'c',
            request = 'launch',
            name = "Debug",
            program = "${file}",
        }
    }

    dap.adapters.c = {
        type = 'executable',
        command = '/usr/bin/lldb',
        name = 'lldb'
    }

    ui.setup()
end

return M
