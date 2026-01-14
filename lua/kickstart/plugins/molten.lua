-- =============================================
--   Molten + Quarto + Otter + Jupytext Setup
--   Recommended config — January 2026
-- =============================================

return {

	----------------------------------------------------------------------------
	-- 1. Molten – Core Jupyter-like experience
	----------------------------------------------------------------------------
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- stay on 1.x until 2.0 is mature
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		ft = { "markdown", "quarto", "ipynb" }, -- important for lazy-loading
		lazy = false, -- many people need eager loading for reliable init

		init = function()
			-- ==================== Core Molten settings ====================
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 0.45
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_screen = false
			vim.g.molten_auto_open_output = false -- prefer manual control
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_max_lines = 16
			vim.g.molten_use_border_highlights = true
			vim.g.molten_output_show_more = true -- … more button
			vim.g.molten_auto_scroll_output = true
			vim.g.molten_virt_text_max_lines = 16

			-- Optional: better experience for quarto/markdown
			vim.g.molten_virt_text_output_lines = 12 -- slightly tighter virt-text
			vim.g.molten_tick_rate = 250 -- smoother updates

			-- ==================== Recommended keymaps ====================
			local map = vim.keymap.set
			local opts = { silent = true, noremap = true, desc = "" }

			-- Kernel / Cell management
			map("n", "<localleader>mi", "<cmd>MoltenInit<CR>", { desc = "Molten: Init kernel" })
			map("n", "<localleader>mr", "<cmd>MoltenReevaluateCell<CR>", { desc = "Molten: Re-run cell" })
			map("n", "<localleader>mR", "<cmd>MoltenReevaluateAll<CR>", { desc = "Molten: Re-run whole file" })

			-- Output window
			map("n", "<localleader>mo", "<cmd>noautocmd MoltenEnterOutput<CR>", { desc = "Molten: Open output" })
			map("n", "<localleader>mh", "<cmd>MoltenHideOutput<CR>", { desc = "Molten: Hide output" })
			map("n", "<localleader>ms", "<cmd>MoltenShowOutput<CR>", { desc = "Molten: Show output" })
			map("n", "<localleader>md", "<cmd>MoltenDelete<CR>", { desc = "Molten: Delete output" })

			-- Raw Molten runners (fallback / debugging)
			map("n", "<localleader>ml", "<cmd>MoltenEvaluateLine<CR>", { desc = "Molten: Run line" })
			map("v", "<localleader>mv", ":<C-u>MoltenEvaluateVisual<CR>", { desc = "Molten: Run visual" })
			map("n", "<localleader>mc", "<cmd>MoltenEvaluateOperator<CR>", { desc = "Molten: Run operator" })
		end,
	},

	----------------------------------------------------------------------------
	-- 2. Jupytext – for seamless ipynb ↔ qmd/md/py
	----------------------------------------------------------------------------
	{
		"GCBallesteros/jupytext.nvim",
		lazy = false, -- ← very important for early loading
		opts = {
			style = "markdown",
			output_extension = "md",
			force_ft = "markdown", -- crucial for quarto + otter
		},
	},

	----------------------------------------------------------------------------
	-- 3. Quarto + Otter – the recommended way to run cells
	----------------------------------------------------------------------------
	{
		"quarto-dev/quarto-nvim",
		dependencies = { "jmbuhr/otter.nvim", "benlubas/molten-nvim", "3rd/image.nvim" },
		ft = { "quarto", "markdown" }, -- lazy-load on these filetypes

		opts = {
			debug = false,
			lspFeatures = {
				enabled = true,
				languages = { "python", "r", "julia", "bash", "lua" }, -- ← customize
				diagnostics = { enabled = true },
				completions = { enabled = true },
			},
			codeRunner = {
				enabled = true,
				default_method = "molten", -- very important
				focus = false,
				ft_runner = {
					python = "molten",
					r = "molten",
					julia = "molten",
				},
				never_run = { "yaml", "json" },
			},
			keymap = { enabled = false }, -- we handle manually
		},

		config = function(_, opts)
			require("quarto").setup(opts)

			-- Delay keymaps until we actually enter a quarto/markdown buffer
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "quarto", "markdown" },
				once = false, -- can run multiple times (for different windows/buffers)
				callback = function()
					local runner = require("quarto.runner")

					local map = vim.keymap.set
					local keymap_opts = { silent = true, noremap = true, buffer = true } -- buffer-local !

					-- Helper function (now safe because runner is required here)
					local function qmap(lhs, func, desc)
						if func then -- extra safety guard
							map("n", lhs, func, vim.tbl_extend("force", keymap_opts, { desc = desc }))
						else
							vim.notify("Quarto runner function missing: " .. desc, vim.log.levels.WARN)
						end
					end

					qmap("<localleader>rc", runner.run_cell, "Quarto: Run Cell")
					qmap("<localleader>ra", runner.run_above, "Quarto: Run Above")
					qmap("<localleader>rb", runner.run_below, "Quarto: Run Below")
					qmap("<localleader>rr", runner.run_all, "Quarto: Run All")

					-- Optional extras
					qmap("<localleader>rl", runner.run_line, "Quarto: Run Line")
					qmap("<localleader>rs", runner.run_range, "Quarto: Run Selected Range (visual)")

					-- Preview is on the main module
					map("n", "<localleader>rp", function()
						require("quarto").quartoPreview()
					end, vim.tbl_extend("force", keymap_opts, { desc = "Quarto: Preview document" }))
				end,
				desc = "Set quarto runner keymaps on filetype",
			})
		end,
	}, ----------------------------------------------------------------------------
	-- 4. Image rendering (kitty is still the best backend in 2026)
	----------------------------------------------------------------------------
	{
		"3rd/image.nvim",
		lazy = true,
		opts = {
			backend = "kitty", -- kitty > ueberzugpp > iterm2
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
			editor_only_render_when_focused = false,
			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif", "*.svg" },
		},
	},
}
