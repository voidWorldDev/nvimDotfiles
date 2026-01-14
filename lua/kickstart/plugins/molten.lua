-- In your plugin spec (lazy.nvim example)

return {
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			-- Main molten settings (very recommended)
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 0.4 -- 40% of window height
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_screen = false
			vim.g.molten_auto_open_output = false -- most people disable auto-open
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_max_lines = 12
			vim.g.molten_use_border_highlights = true
			vim.g.molten_output_show_more = true

			-- Very useful keymaps (add to which-key / your mappings)
			vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Molten Init kernel" })
			vim.keymap.set("n", "<localleader>mr", ":MoltenReevaluateCell<CR>", { desc = "Re-run cell" })
			vim.keymap.set("n", "<localleader>mo", ":noautocmd MoltenEnterOutput<CR>", { desc = "Open output" })
			vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>", { desc = "Hide output" })
			vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "Delete cell output" })
			vim.keymap.set("n", "<localleader>ms", ":MoltenShowOutput<CR>", { desc = "Show output" })

			-- Most popular running mappings
			vim.keymap.set("n", "<localleader>ml", ":MoltenEvaluateLine<CR>", { desc = "Run line" })
			vim.keymap.set("v", "<localleader>mv", ":<C-u>MoltenEvaluateVisual<CR>", { desc = "Run visual" })
			vim.keymap.set("n", "<localleader>mc", ":MoltenEvaluateOperator<CR>", { desc = "Run operator (motion)" })
			vim.keymap.set("n", "<localleader>ma", ":MoltenEvaluateAllAbove<CR>", { desc = "Run all above" })
		end,
	},
	{
		"GCBallesteros/jupytext.nvim",
		lazy = false, -- important: load early
		opts = {
			style = "markdown",
			output_extension = "md",
			force_ft = "markdown", -- crucial for quarto/otter to activate
		},
	},

	-- 2. quarto-nvim (cell highlighting, navigation, runner integration)
	{
		"quarto-dev/quarto-nvim",
		dependencies = { "jmbuhr/otter.nvim" },
		opts = {
			lspFeatures = {
				languages = { "python" }, -- add others if needed
				diagnostics = { enabled = true },
				completions = { enabled = true },
			},
			codeRunner = {
				enabled = true,
				default_method = "molten", -- tells quarto to use molten to run code
			},
		},
	},
	-- Almost mandatory for good image support
	{
		"3rd/image.nvim",
		opts = {
			backend = "kitty", -- or "ueberzug" / "iterm2" depending on your terminal
			integrations = {
				markdown = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = false,
				},
			},
			max_height_window_percentage = 50,
			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
		},
	},
}
