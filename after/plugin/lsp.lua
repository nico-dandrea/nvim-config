---@diagnostic disable: undefined-global

-- ✅ Safe require wrappers
local ok_mason, mason = pcall(require, "mason")
if not ok_mason then return end

local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok_mason_lsp then return end

local ok_cmp_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok_cmp_lsp then return end
if not (vim.lsp and vim.lsp.config and vim.lsp.enable) then return end

local capabilities = cmp_nvim_lsp.default_capabilities()
local servers = {
    "intelephense",
    "jsonls",
    "bashls",
    "eslint",
    "dockerls",
    "pyright",
    "phpactor",
    "lua_ls",
    "html",
    "cssls",
    "ts_ls",
}

mason.setup()
mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = false,
})

-- ✅ Configure servers via vim.lsp.config (new API in 0.11)
local function setup_lua_ls()
    vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                    library = { vim.env.VIMRUNTIME },
                    checkThirdParty = false,
                },
            },
        },
    })
end

local function setup_phpactor()
    local cmd
    if vim.fn.filereadable("./vendor/bin/sail") == 1 then
        cmd = { "./vendor/bin/sail", "php", "./vendor/bin/phpactor", "language-server" }
    elseif vim.fn.executable("phpactor") == 1 then
        cmd = { "phpactor", "language-server" }
    end

    if not cmd then
        vim.notify("Skipping phpactor (no sail or phpactor found)", vim.log.levels.WARN)
        return
    end

    vim.lsp.config("phpactor", {
        capabilities = capabilities,
        cmd = cmd,
    })
end

local function setup_default(server)
    vim.lsp.config(server, { capabilities = capabilities })
end

for _, server in ipairs(servers) do
    if server == "phpactor" then
        setup_phpactor()
    elseif server == "lua_ls" then
        setup_lua_ls()
    else
        setup_default(server)
    end
end

-- ✅ Enable them (filetype-based attach)
for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
    vim.lsp.enable(server)
end

-- ✅ Global LSP keymaps (attach once per buffer)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
    callback = function(event)
        local opts = { buffer = event.buf }
        local map = vim.keymap.set
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        map("n", "<leader>vd", vim.diagnostic.open_float, opts)
        map("n", "[d", vim.diagnostic.goto_next, opts)
        map("n", "]d", vim.diagnostic.goto_prev, opts)
        map("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        map("n", "<leader>vrr", vim.lsp.buf.references, opts)
        map("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        map("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    end,
})

-- ✅ Blade detection
vim.filetype.add({
    pattern = { [".*%.blade%.php"] = "blade" },
})

-- ✅ Diagnostics config
vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        severity = vim.diagnostic.severity.ERROR,
    },
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
})
