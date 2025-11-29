-- /Users/ndandrea/.config/nvim/after/plugin/null-ls.lua
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        ------------------------------------------------------------------------
        -- 🐘 PHP tools (via Sail)
        ------------------------------------------------------------------------
        null_ls.builtins.formatting.pint.with({
            command = "./vendor/bin/sail",
            args = { "php", "./vendor/bin/pint", "--stdin", "--preset=laravel" },
            to_stdin = true,
        }),
        null_ls.builtins.formatting.phpcsfixer.with({
            command = "./vendor/bin/sail",
            args = {
                "php", "./vendor/bin/php-cs-fixer",
                "fix",
                "--using-cache=no",
                "--quiet",
                "--stdin", "$FILENAME",
            },
            to_stdin = true,
        }),
        null_ls.builtins.diagnostics.phpstan.with({
            command = "./vendor/bin/sail",
            args = { "php", "./vendor/bin/phpstan", "analyse", "--error-format=raw", "-" },
        }),
        null_ls.builtins.diagnostics.phpcs.with({
            command = "./vendor/bin/sail",
            args = {
                "php", "./vendor/bin/phpcs",
                "--standard=PSR12",
                "--report=json",
                "--stdin-path", "$FILENAME", "-",
            },
            to_stdin = true,
        }),

        ------------------------------------------------------------------------
        -- 🧠 JavaScript / TypeScript / Angular
        ------------------------------------------------------------------------
        -- Prettier for formatting
        null_ls.builtins.formatting.prettier.with({
            filetypes = {
                "javascript", "typescript", "typescriptreact",
                "vue", "json", "html", "css", "scss", "yaml",
                "markdown", "graphql",
            },
            extra_filetypes = { "php", "blade.php" },
            prefer_local = "node_modules/.bin",
        }),

        -- ESLint diagnostics + formatting + code actions (via none-ls.nvim)
        require("none-ls.diagnostics.eslint_d").with({
            condition = function(utils)
                return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" })
            end,
            prefer_local = "node_modules/.bin",
        }),
        require("none-ls.code_actions.eslint_d").with({
            prefer_local = "node_modules/.bin",
        }),
        require("none-ls.formatting.eslint_d").with({
            prefer_local = "node_modules/.bin",
        }),
    },

    ------------------------------------------------------------------------
    -- ✨ Autoformat on save
    ------------------------------------------------------------------------
    -- on_attach = function(client, bufnr)
    --     if client.supports_method("textDocument/formatting") then
    --         vim.api.nvim_clear_autocmds({ buffer = bufnr })
    --         vim.api.nvim_create_autocmd("BufWritePre", {
    --             buffer = bufnr,
    --             callback = function()
    --                 vim.lsp.buf.format({ bufnr = bufnr })
    --             end,
    --         })
    --     end
    -- end,
})

