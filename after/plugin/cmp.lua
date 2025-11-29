local ok_cmp, cmp = pcall(require, "cmp")
if not ok_cmp then return end

local cmp_select = { behavior = cmp.SelectBehavior.Select }
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  experimental = { ghost_text = true },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip", keyword_length = 2 },
    { name = "buffer", keyword_length = 3 },
    { name = "path" },
  }),
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
})
