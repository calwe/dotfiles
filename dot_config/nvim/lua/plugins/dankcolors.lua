return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#0a1519',
				base01 = '#0a1519',
				base02 = '#93a1a5',
				base03 = '#93a1a5',
				base04 = '#e8f9ff',
				base05 = '#f5fcff',
				base06 = '#f5fcff',
				base07 = '#f5fcff',
				base08 = '#ff74a2',
				base09 = '#ff74a2',
				base0A = '#61dcff',
				base0B = '#7dff8a',
				base0C = '#abecff',
				base0D = '#61dcff',
				base0E = '#7de2ff',
				base0F = '#7de2ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#93a1a5',
				fg = '#f5fcff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#61dcff',
				fg = '#0a1519',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#93a1a5' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#abecff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#7de2ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#61dcff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#61dcff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#abecff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#7dff8a',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#e8f9ff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#e8f9ff' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#93a1a5',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
