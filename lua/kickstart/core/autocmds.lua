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
