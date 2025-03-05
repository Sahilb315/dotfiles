return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep (search inside files)" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find open buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search help tags" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recently opened files" })
		vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Find git files" })
		vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
		vim.keymap.set("n", "<leader>fc", builtin.command_history, { desc = "Search command history" })
		vim.keymap.set("n", "<leader>ft", builtin.tags, { desc = "Search tags (for symbols in code)" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Search keymaps" })
		vim.keymap.set("n", "<leader>fr", builtin.grep_string, { desc = "Grep string under cursor" })
		vim.keymap.set("n", "<leader>uc", builtin.colorscheme, { desc = "List available colorschemes" })

		vim.keymap.set("n", "<leader>sd", builtin.lsp_document_symbols, { desc = "LSP document symbols" })
		vim.keymap.set("n", "<leader>sw", builtin.lsp_workspace_symbols, { desc = "LSP workspace symbols" })
		vim.keymap.set("n", "<leader>xs", builtin.diagnostics, { desc = "Show diagnostics" })
		vim.keymap.set("n", "<leader>ss", vim.lsp.buf.signature_help, { desc = "Show signature help" })

		vim.keymap.set("n", "<leader>fn", builtin.treesitter, { desc = "List func names, variables" })
		require("telescope").setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
			},
		})
	end,
}
