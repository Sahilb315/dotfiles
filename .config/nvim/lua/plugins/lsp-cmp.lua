return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"ts_ls",
					"eslint",
					"html",
					"cssls",
					"pyright",
					"jsonls",
				},
				automatic_installation = true,
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"lua-language-server",
					"gopls",
					"stylua",
					"shellcheck",
					"shfmt",
					"prettierd",
				},
				auto_update = false,
				run_on_start = true,
				debounce_hours = 5,
			})
		end,
	},
	{ "tpope/vim-surround" },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
			"mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>f", function()
					vim.lsp.buf.format({ async = false })
				end, opts)
			end

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
					},
				},
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
					},
				},
			})
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
				end,
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
				end,
				filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
			})

			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.eslint.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.html.setup({ capabilities = capabilities, on_attach = on_attach })
			lspconfig.cssls.setup({ capabilities = capabilities, on_attach = on_attach })
			lspconfig.jsonls.setup({ capabilities = capabilities, on_attach = on_attach })
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
}
