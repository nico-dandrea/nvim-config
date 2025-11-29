local dap = require('dap')
local dapui = require("dapui")
dapui.setup()

dap.adapters.php = {
    type = 'executable',
    command = 'node',  -- Xdebug port
    args = { '/Users/ndandrea/.local/share/nvim/site/pack/packer/start/vscode-php-debug/out/phpDebug.js' },
}

dap.configurations.php = {
    {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug",
        port = 9003,
        pathMappings = {
            ["/var/www/html/core/main_repo/public_html"] = "${workspaceFolder}/core/main_repo/public_html",
        }
    }
}
-- Key mappings for debugging
vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)
vim.keymap.set('n', '<F12>', dap.step_out)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>B', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
vim.keymap.set('n', '<leader>dr', dap.repl.open)

-- Automatically open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
