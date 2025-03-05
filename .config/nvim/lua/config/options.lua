vim.opt.clipboard = "unnamedplus"
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 4 -- Number of spaces a tab is equal to
vim.opt.shiftwidth = 2 -- Number of spaces to use for each indent
vim.opt.smartindent = true -- Enable smart indentation
vim.opt.smarttab = true -- Enable smart tabbing
vim.opt.autoindent = true -- Enable automatic indentation
vim.opt.copyindent = true -- Copy the current indentation of the line
vim.opt.wrap = false -- Don't wrap lines
vim.opt.linebreak = true -- Break lines at convenient places (like spaces)
vim.opt.scrolloff = 8 -- Keep 8 lines visible when scrolling
vim.opt.sidescrolloff = 8 -- Keep 8 columns visible when scrolling horizontally
vim.opt.cursorline = true -- Highlight the current line
vim.opt.termguicolors = true -- Enable true color support
vim.opt.background = "dark" -- Set background to dark (can also use "light")
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Override 'ignorecase' if search contains uppercase
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Show search results as you type
vim.opt.completeopt = "menu,menuone,noselect" -- Autocompletion settings

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- For global window borders
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#d79921", bold = true })
vim.opt.winblend = 0
vim.opt.pumblend = 0
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#d79921", bold = true })

-- If you want to make Neo-tree borders bold too
vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#d79921", bold = true })
vim.filetype.add({
	extension = {
		tsx = "typescriptreact",
	},
})
