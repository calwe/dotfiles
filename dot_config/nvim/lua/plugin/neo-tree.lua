vim.pack.add({ "https://github.com/antosha417/nvim-lsp-file-operations" })

require("neo-tree").setup()

require("lsp-file-operations").setup()

vim.keymap.set({ "n", "v" }, "<leader>t", "<cmd>NeoTreeRevealToggle<cr>", { desc = "Toggle file explorer" })

local spec_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"

local function read_base16_colors()
	local ok, lines = pcall(vim.fn.readfile, spec_path)
	if not ok then return {} end
	local colors = {}
	for _, line in ipairs(lines) do
		local key, value = line:match("%s*(base%w%w)%s*=%s*'(#%x+)'")
		if key and value then
			colors[key] = value
		end
	end
	return colors
end

local function apply_neotree_colors()
	local c = read_base16_colors()
	if not c.base00 then return end
	vim.api.nvim_set_hl(0, "NeoTreeNormal",             { bg = c.base00, fg = c.base05 })
	vim.api.nvim_set_hl(0, "NeoTreeNormalNC",           { link = "NeoTreeNormal" })
	vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer",        { bg = c.base00, fg = c.base00 })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryName",      { fg = c.base0D })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon",      { fg = c.base0D })
	vim.api.nvim_set_hl(0, "NeoTreeRootName",           { fg = c.base0C, bold = true })
	vim.api.nvim_set_hl(0, "NeoTreeFileName",           { fg = c.base05 })
	vim.api.nvim_set_hl(0, "NeoTreeFileNameOpened",     { fg = c.base05, bold = true })
	vim.api.nvim_set_hl(0, "NeoTreeSymbolicLinkTarget", { fg = c.base0C, italic = true })
	vim.api.nvim_set_hl(0, "NeoTreeIndentMarker",       { fg = c.base03 })
	vim.api.nvim_set_hl(0, "NeoTreeExpander",           { fg = c.base03 })
	vim.api.nvim_set_hl(0, "NeoTreeGitAdded",           { fg = c.base0B })
	vim.api.nvim_set_hl(0, "NeoTreeGitModified",        { fg = c.base0E })
	vim.api.nvim_set_hl(0, "NeoTreeGitDeleted",         { fg = c.base08 })
	vim.api.nvim_set_hl(0, "NeoTreeGitConflict",        { fg = c.base08, bold = true })
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked",       { fg = c.base0C })
	vim.api.nvim_set_hl(0, "NeoTreeGitIgnored",         { fg = c.base03 })
	vim.api.nvim_set_hl(0, "NeoTreeGitStaged",          { fg = c.base0B, bold = true })
	vim.api.nvim_set_hl(0, "NeoTreeGitRenamed",         { fg = c.base0D })
end

apply_neotree_colors()

if not _G._neotree_theme_watcher then
	local uv = vim.uv or vim.loop
	_G._neotree_theme_watcher = uv.new_fs_event()
	_G._neotree_theme_watcher:start(spec_path, {}, vim.schedule_wrap(function()
		vim.defer_fn(function()
			apply_neotree_colors()
			vim.cmd.redraw()
		end, 50)
	end))
end
