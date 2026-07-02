return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",

	config = function()
		local ufo = require("ufo")

		ufo.setup()

		-- Fold keymaps
		vim.keymap.set("n", "<leader>za", "za", { remap = true, desc = "Toggle fold" })
		vim.keymap.set("n", "<leader>zo", "zo", { remap = true, desc = "Open fold" })
		vim.keymap.set("n", "<leader>zc", "zc", { remap = true, desc = "Close fold" })
		vim.keymap.set("n", "<leader>zr", "zr", { remap = true, desc = "Open one fold level" })
		vim.keymap.set("n", "<leader>zm", "zm", { remap = true, desc = "Close one fold level" })

		-- UFO-specific
		vim.keymap.set("n", "<leader>zR", ufo.openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "<leader>zM", ufo.closeAllFolds, { desc = "Close all folds" })
	end,
}
