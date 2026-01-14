-- Highlight on yank (very common & useful)
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch", -- you can also try "Visual", "Search", etc.
			timeout = 200, -- default is 150ms
		})
	end,
})

-- Wrap + spell for prose-writing filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "markdown", "text", "txt", "mail" },
	desc = "Enable wrap and spellcheck for prose files",
	group = vim.api.nvim_create_augroup("prose-settings", { clear = true }),
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "en" } -- you may want "en_us", "en_gb", etc.
		-- vim.opt_local.linebreak = true    -- optional: better line wrapping
	end,
})

-- Auto-activate Quarto (very important for quarto users!)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "quarto", "ipynb" },
	desc = "Auto-activate Quarto when opening supported files",
	group = vim.api.nvim_create_augroup("quarto-auto-activate", { clear = true }),
	callback = function(ev)
		-- Only try to activate if quarto.nvim is actually available
		if vim.fn.exists(":QuartoActivate") == 2 then
			vim.cmd("QuartoActivate")
		end
	end,
})
