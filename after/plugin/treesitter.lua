require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "typescript",
        "php",
        "bash",
        "css",
        "dockerfile",
        "json",
        "python",
        "sql"
    },

    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },

    indent = {
        enable = true,
        disable = { "blade" },
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",  -- Start selection
            node_incremental = "grn",  -- Increment to the next node
            scope_incremental = "grc",  -- Increment to the scope
            node_decremental = "grm",  -- Decrement selection
        },
    },


    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "blade" },
    },
}
