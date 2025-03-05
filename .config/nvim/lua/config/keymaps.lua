vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", ":noh<CR>", { silent = true })
vim.keymap.set("n", "<Esc>", ":noh<CR>", { silent = true })

vim.api.nvim_set_keymap(
    "n",
    "<leader>xd",
    ":lua vim.diagnostic.open_float(nil, { focus = true })<CR>",
    { desc = "Open Current Diagnostic", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>xl",
    ":lua vim.diagnostic.setqflist()<CR>:copen<CR>",
    { desc = "Open diagnostic list", noremap = true, silent = true }
)

vim.keymap.set("n", "<C-s>", function()
    vim.cmd("write")  -- Save the file
    vim.lsp.buf.format() -- Format the file using LSP (if available)
end, { desc = "Save and format the file" })

vim.keymap.set("i", "<C-s>", function()
    vim.cmd("write")  -- Save the file
    vim.lsp.buf.format() -- Format the file using LSP (if available)
end, { desc = "Save and format the file", silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>ca",
    "<cmd>lua vim.lsp.buf.code_action()<CR>",
    { noremap = true, silent = true, desc = "Code Action" }
)
