-- lua/mine/commands.lua

local function run_cmd(cmd)
  vim.cmd("!" .. cmd)
end

-- Sail path
local sail_path = vim.fn.executable("./vendor/bin/sail") == 1 and "./vendor/bin/sail" or "sail"

-- :Sail <args>
vim.api.nvim_create_user_command("Sail", function(opts)
  run_cmd(sail_path .. " " .. opts.args)
end, {
  nargs = "*",        -- Accept variable args
})

-- :Artisan <args> (shortcut for Sail artisan ...)
vim.api.nvim_create_user_command("Artisan", function(opts)
  run_cmd(sail_path .. " artisan " .. opts.args)
end, {
  nargs = "*",
})

-- Other useful examples

-- :Config opens your config directory
vim.api.nvim_create_user_command("Config", function()
  vim.cmd("e ~/.config/nvim/")
end, {})

-- :ReloadConfig reloads init.lua
vim.api.nvim_create_user_command("ReloadConfig", function()
  vim.cmd("source ~/.config/nvim/init.lua")
  print("✅ Config reloaded")
end, {})

-- :TrimWhitespace
vim.api.nvim_create_user_command("TrimWhitespace", function()
  vim.cmd([[%s/\s\+$//e]])
end, {})

-- :WhereAmI shows current file and directory
vim.api.nvim_create_user_command("WhereAmI", function()
  print("📁 " .. vim.fn.getcwd())
  print("📄 " .. vim.api.nvim_buf_get_name(0))
end, {})

