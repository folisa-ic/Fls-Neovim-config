local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- tree
    { "kyazdani42/nvim-tree.lua", event = "VimEnter", dependencies = "nvim-tree/nvim-web-devicons" },
    -- LSP manager
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- Vscode-like pictograms
    {
        "onsails/lspkind.nvim",
        event = { "VimEnter" },
    },
    -- Auto-completion engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
            "hrsh7th/cmp-buffer",   -- buffer auto-completion
            "hrsh7th/cmp-path",     -- path auto-completion
            "hrsh7th/cmp-cmdline",  -- cmdline auto-completion
        },
        config = function()
            require("config.nvim-cmp")
        end,
    },
    -- Code snippet engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        config = function()
            local ls = require("luasnip")
            local types = require("luasnip.util.types")

            -- 配置 LuaSnip
            ls.config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
            })

            vim.api.nvim_set_keymap('i', '<C-l>', '<cmd>lua require("luasnip").expand_or_jump()<CR>', {})
            vim.api.nvim_set_keymap('s', '<C-l>', '<cmd>lua require("luasnip").expand_or_jump()<CR>', {})

            -- 按需加载代码片段
            require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })
        end
    },
    "tanvirtin/monokai.nvim",
    {
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

            require('telescope').setup {
                defaults = {
                    -- 默认配置项
                    prompt_prefix = "🔍 ",
                    selection_caret = "➤ ",
                    path_display = { "truncate" },
                },
                pickers = {
                    find_files = {
                        theme = "dropdown", -- 使用下拉菜单主题
                    },
                },
            }
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
            -- 确保 languages 表中仅包含你需要的语言
                ensure_installed = { "c", "cpp", "python", "lua", "vim" },
                highlight = {
                    enable = true,              -- 启用高亮支持
                    additional_vim_regex_highlighting = false,
                },
            }
        end
    },
})
