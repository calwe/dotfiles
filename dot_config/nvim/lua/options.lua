local opts = {
    termguicolors = true,
	shiftwidth = 4,
	tabstop = 4,
	expandtab = true,
	wrap = false,
	termguicolors = true,
	number = true,
	relativenumber = true,
	autoread = true,
}

-- Set options from table
for opt, val in pairs(opts) do
	vim.o[opt] = val
end

-- Auto-reload files when changed externally
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	command = "checktime",
	desc = "Check for external file changes and reload buffer",
})

-- Compat shim: nvim 0.11 removed ft_to_lang (telescope still uses it)
if vim.treesitter.language and not vim.treesitter.language.ft_to_lang then
	vim.treesitter.language.ft_to_lang = vim.treesitter.language.get_lang
end
