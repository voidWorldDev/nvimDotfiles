return {

	-----------------------------------------------------------------------------
	-- 1. Molten – Jupyter-like notebook experience in Neovim
	-----------------------------------------------------------------------------
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use <2.0.0 to avoid big breaking changes
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		event = "VeryLazy", -- or "BufReadPre *.ipynb,*.qmd,*.ju.md" etc.

		init = function()
			-- ==================== Recommended Molten settings ====================
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 0.45 -- 45% of window
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_screen = false
			vim.g.molten_auto_open_output = false -- most people prefer manual control
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_max_lines = 14
			vim.g.molten_use_border_highlights = true
			vim.g.molten_output_show_more = true -- … more button
			vim.g.molten_auto_scroll_output = true -- useful when running many cells
			vim.g.molten_virt_text_max_lines = 16 -- a bit more generous

			-- ==================== Popular & recommended keymaps ====================
			local map = vim.keymap.set
			local opts = { silent = true, noremap = true }

			-- Cell / Kernel management
			map("n", "<localleader>mi", "<cmd>MoltenInit<CR>", { desc = "Molten: Init kernel", unpack(opts) })
			map("n", "<localleader>mk", "<cmd>MoltenInit<CR>", { desc = "Molten: (re)Init kernel", unpack(opts) })
			map("n", "<localleader>mr", "<cmd>MoltenReevaluateCell<CR>", { desc = "Molten: Re-run cell", unpack(opts) })
			map(
				"n",
				"<localleader>mR",
				"<cmd>MoltenReevaluateAll<CR>",
				{ desc = "Molten: Re-run whole file", unpack(opts) }
			)

			-- Output window control
			map(
				"n",
				"<localleader>mo",
				"<cmd>noautocmd MoltenEnterOutput<CR>",
				{ desc = "Molten: Open output", unpack(opts) }
			)
			map("n", "<localleader>mh", "<cmd>MoltenHideOutput<CR>", { desc = "Molten: Hide output", unpack(opts) })
			map("n", "<localleader>ms", "<cmd>MoltenShowOutput<CR>", { desc = "Molten: Show output", unpack(opts) })
			map("n", "<localleader>md", "<cmd>MoltenDelete<CR>", { desc = "Molten: Delete cell output", unpack(opts) })

			-- Most used – running code
			map("n", "<localleader>ml", "<cmd>MoltenEvaluateLine<CR>", { desc = "Molten: Run line", unpack(opts) })
			map(
				"v",
				"<localleader>mv",
				":<C-u>MoltenEvaluateVisual<CR>",
				{ desc = "Molten: Run visual selection", unpack(opts) }
			)
			map(
				"n",
				"<localleader>mc",
				"<cmd>MoltenEvaluateOperator<CR>",
				{ desc = "Molten: Run with motion (operator)", unpack(opts) }
			)
			map(
				"n",
				"<localleader>ma",
				"<cmd>MoltenEvaluateAllAbove<CR>",
				{ desc = "Molten: Run all cells above", unpack(opts) }
			)
			map(
				"n",
				"<localleader>mb",
				"<cmd>MoltenEvaluateAllBelow<CR>",
				{ desc = "Molten: Run all cells below", unpack(opts) }
			)

			-- Bonus / less frequent but useful
			map(
				"n",
				"<localleader>mp",
				"<cmd>MoltenPaste<CR>",
				{ desc = "Molten: Paste last yanked output", unpack(opts) }
			)
		end,
	},

	-----------------------------------------------------------------------------
	-- 2. Jupytext – seamless .ipynb ↔ .py/.md/.qmd editing
	-----------------------------------------------------------------------------
	{
		"GCBallesteros/jupytext.nvim",
		lazy = false, -- very important: should load early
		opts = {
			style = "markdown", -- or "hydrogen", "percent", "light"
			output_extension = "md",
			force_ft = "markdown", -- crucial for quarto & otter to work properly
		},
	},

	-----------------------------------------------------------------------------
	-- 3. Quarto + Otter – best Quarto experience + LSP in code cells
	-----------------------------------------------------------------------------
	{
		"quarto-dev/quarto-nvim",
		dependencies = { "jmbuhr/otter.nvim" },
		ft = { "quarto", "markdown" }, -- can be lazy-loaded
		opts = {
			lspFeatures = {
				enabled = true,
				languages = { "python", "r", "julia", "bash" }, -- ← add what you use
				diagnostics = { enabled = true },
				completions = { enabled = true },
			},
			codeRunner = {
				enabled = true,
				default_method = "molten", -- very important!
				focus = false,
			},
			keymap = {
				enabled = false, -- we define our own below / use which-key
			},
		},
	},

	-----------------------------------------------------------------------------
	-- 4. Image.nvim – best image rendering experience (kitty recommended)
	-----------------------------------------------------------------------------
	{
		"3rd/image.nvim",
		lazy = true,
		opts = {
			backend = "kitty", -- "kitty" > "ueberzugpp" > "iterm2"
			integrations = {
				markdown = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = false,
				},
			},
			max_height_window_percentage = 50,
			max_width_window_percentage = 100,
			max_height = nil, -- useful when you have small floating windows
			editor_only_render_when_focused = false,
			hijack_file_patterns = {
				"*.png",
				"*.jpg",
				"*.jpeg",
				"*.gif",
				"*.webp",
				"*.avif",
				"*.svg",
			},
		},
	},
}
