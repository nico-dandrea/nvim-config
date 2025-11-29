-- lua/mine/packer.lua
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Core
    use 'wbthomason/packer.nvim'
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.6', requires = { 'nvim-lua/plenary.nvim' } }
    use 'AlexvZyl/nordic.nvim'
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('ThePrimeagen/vim-be-good')

    -- LSP + completion
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'nvimtools/none-ls.nvim' },
            { 'phpactor/phpactor' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    -- UI/format/git
    use { 'glepnir/lspsaga.nvim', branch = 'main', config = function() require('lspsaga').setup({}) end }
    use 'nvim-tree/nvim-web-devicons'
    use { 'nvimtools/none-ls.nvim' }
    use('nvimtools/none-ls-extras.nvim')
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function() require('gitsigns')
            .setup() end }

    -- Laravel / Blade
    use { 'adalessa/laravel.nvim', requires = { 'kevinhwang91/promise-async' } }
    use { 'jwalton512/vim-blade', ft = 'blade' }
    use('emmanueltouzery/agitator.nvim')
    use('themaxmarchuk/tailwindcss-colors.nvim')
    use('gbprod/phpactor.nvim')
    use('MunifTanjim/nui.nvim')

    -- Debug
    use { 'mfussenegger/nvim-dap',
        requires = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'nvim-telescope/telescope-dap.nvim',
            'nvim-neotest/nvim-nio'
        }
    }
    use 'xdebug/vscode-php-debug'

    use {
      'Exafunction/codeium.vim',
    }

    --[[
  use({
    "robitx/gp.nvim",
    requires = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    config = function()
      require("gp").setup({
        override_default_agents = true,
        providers = {
          openai = {
            endpoint = "https://api.openai.com/v1/chat/completions",
            secret = os.getenv("OPENAI_API_KEY"),
          },
        },
        agents = {
          {
            name = "ChatGPT-4o-Mini",
            provider = "openai",
            chat = true, command = true,
            model = { model = "gpt-4o-mini" },
            system_prompt = "You are a fast coding assistant. Be concise.",
          },
          {
            name = "ChatGPT-4o",
            provider = "openai",
            chat = true, command = true,
            model = { model = "gpt-4o" },
            system_prompt = "You are a powerful coding assistant. Provide detailed, accurate help.",
          },
        },
        default_command_agent = "ChatGPT-4o-Mini",
        default_chat_agent = "ChatGPT-4o",
      })
    end,
  })

  use {
    'milanglacier/minuet-ai.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('minuet').setup({
        provider = 'openai',
        openai = { model = 'gpt-4o-mini' },
        request_timeout = 3,
        virtualtext = { auto_trigger_ft = {}, keymap = { accept='<A-l>', next='<A-]>', prev='<A-[>', dismiss='<A-e>' } },
        cmp = { enable = true },
      })
    end
  }
  --]]
end)
