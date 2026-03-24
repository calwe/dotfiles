vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })

local ibl = require("ibl")
local hooks = require("ibl.hooks")

local spec_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"

-- Base16 color slots to cycle through for rainbow levels
-- Chosen for visual distinction: pink, cyan, green, light-cyan, blue
local color_keys = { "base08", "base0D", "base0B", "base0C", "base0E" }
local rainbow_groups = { "IblRainbow1", "IblRainbow2", "IblRainbow3", "IblRainbow4", "IblRainbow5" }

-- Blend fg toward bg (simulates transparency: amount=0 is full colour, 1 is invisible)
local function blend(fg, bg, amount)
	local fr, fg_, fb = tonumber(fg:sub(2,3),16), tonumber(fg:sub(4,5),16), tonumber(fg:sub(6,7),16)
	local br, bg_, bb = tonumber(bg:sub(2,3),16), tonumber(bg:sub(4,5),16), tonumber(bg:sub(6,7),16)
	return string.format("#%02x%02x%02x",
		math.floor(fr + (br - fr) * amount),
		math.floor(fg_ + (bg_ - fg_) * amount),
		math.floor(fb + (bb - fb) * amount))
end

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

local function apply_rainbow_groups()
	local colors = read_base16_colors()
	local bg = colors["base00"] or "#000000"
	for i, group in ipairs(rainbow_groups) do
		local fg = colors[color_keys[i]]
		if fg then
			vim.api.nvim_set_hl(0, group, { fg = blend(fg, bg, 0.8) })
		end
	end
end

hooks.register(hooks.type.HIGHLIGHT_SETUP, apply_rainbow_groups)

ibl.setup({
	indent = {
		highlight = rainbow_groups,
		char = "│",
	},
	scope = { enabled = false },
})

-- Watch the generated theme file and refresh rainbow groups when colors change.
-- Defers 50ms so the dankcolors watcher applies the base theme first.
if not _G._ibl_theme_watcher then
	local uv = vim.uv or vim.loop
	_G._ibl_theme_watcher = uv.new_fs_event()
	_G._ibl_theme_watcher:start(spec_path, {}, vim.schedule_wrap(function()
		vim.defer_fn(function()
			apply_rainbow_groups()
			vim.cmd.redraw()
		end, 50)
	end))
end
