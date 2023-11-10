return {
	{
		"williamboman/mason.nvim",
		init = function ()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		init = function ()
			require("mason-lspconfig").setup()
		end,
	},
}
