return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			window = {
				width = 26,
			},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = true,
					hide_gitignored = true,
					hide_by_name = {
						".git",
						".DS_Store",
					},
					always_show = {
						".gitignore",
						".env",
						"shell.nix",
					},
					never_show = {
						".DS_Store",
					},
					show_hidden_count = true,
				},
				follow_current_file = {
					enabled = true,
				},
				group_empty_dirs = true,
				use_libuv_file_watcher = true,
			},
		})
		vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", { noremap = true, silent = true, desc = "Toggle Neo-tree" })
	end,
}
