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
                fold = {
                    enable = true,
                },
            }
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    "Yggdroot/indentLine",
    "akinsho/bufferline.nvim",
})

local statusbf, bufferline = pcall(require, "bufferline")
vim.keymap.set('n', 'cc', function()
    if vim.bo.modified then
        vim.cmd.write()
    end
    local buf = vim.fn.bufnr()
    bufferline.cycle(-1)
    vim.cmd.bdelete(buf)
end)

if not statusbf then
    vim.notify("do not find bufferline")
  return
end

local statusll, lualine = pcall(require, "lualine")
if not statusll then
	vim.notify("do not find lualine")
	return
end

bufferline.setup({
	options = {
        indicator = {
			icon = '▎', -- 分割线
			style = 'underline',
		},
		buffer_close_icon = '󰅖',
		modified_icon = '●',
		close_icon = '',
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "left",
				separator = true,
			},
		},
	},
})

lualine.setup({
	options = {
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = " ", right = "" },
	},
	extensions = { "nvim-tree", "toggleterm" },
	sections = {
		lualine_a = {
			{
				"mode",
				icons_enabled = true,
			},
		},
		lualine_b = {
			{
				"filetype",
				colored = true,
				icon_only = true,
			},
			"filename",
		},
		lualine_c = {
			"branch",
			"diff",
		},
		lualine_x = {
            "filesize",
        },
		lualine_y = {
            {
			    "fileformat",
			    symbols = {
			    	unix = '', -- e712
			    	dos = '', -- e70f
			    	mac = "", -- e711
			    },
            },
            "encoding",
        },
		lualine_z = {
			"progress",
		},
	},
})
