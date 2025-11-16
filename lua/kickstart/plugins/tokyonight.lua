-- TOKYONIGHT — THE REAL DARK BLUE ONE
return {
	"folke/tokyonight.nvim",
	lazy = false, -- load immediately
	priority = 1000, -- highest priority
	opts = {
		style = "storm", -- this is the dark-blue one
		transparent = false,
		terminal_colors = false,
		styles = {
			sidebars = "dark-blue",
			floats = "dark",
		},
		on_colors = function(colors)
			colors.border = "#7aa2f7" -- beautiful blue border
		end,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd([[colorscheme tokyonight-storm]])
		vim.cmd([[hi NormalFloat guibg=#1a1b26]]) -- fix floating window bg
	end,
}
