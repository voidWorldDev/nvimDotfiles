return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("render-markdown").setup({
			render_modes = { "n", "i", "v" }, -- render in normal, insert, and visual
		})

		-- Required so conceal works in insert mode
		vim.opt.conceallevel = 2
		vim.opt.concealcursor = "niv" -- show rendered text in insert + normal + visual
	end,
}
