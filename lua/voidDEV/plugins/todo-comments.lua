return {
	"folke/todo-comments.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	opts = {
		signs = false,
		keywords = {
			MTODO = {
				icon = "⭐",
				color = "warning",
				alt = { "MINE" }, -- optional aliases
			},
		},
	},
	keys = {
		{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
		{ "<leader>sm", "<cmd>TodoTelescope keywords=MTODO<cr>", desc = "My Todos" },
	},
}
