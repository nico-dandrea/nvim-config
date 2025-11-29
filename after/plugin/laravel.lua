require("laravel").setup()
pcall(function()
  require("telescope").load_extension("laravel")
end)
