return {
	"OXY2DEV/markview.nvim",
	ft = { "markdown" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("markview").setup({
			preview = {
				enabled = true, -- live preview ON
				update = "live", -- update on each keystroke
			},
			hybrid = true, -- shows both raw + rendered (like Obsidian)
		})
	end,
}
