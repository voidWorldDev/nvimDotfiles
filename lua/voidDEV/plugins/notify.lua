return {
	"rcarriga/nvim-notify",
	lazy = false,
	keys = {
		{
			"<leader>n",
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			desc = "Dismiss notifications",
		},
	},
	config = function()
		local notify = require("notify")
		notify.setup({
			timeout = 3000,
			stages = "fade",
			render = "default",
		})
		vim.notify = notify
	end,
}

-- | Render              | Description                                                                                |
-- | ------------------- | ------------------------------------------------------------------------------------------ |
-- | `"default"`         | Standard layout with title, icon, and message. This is the default and most commonly used. |
-- | `"minimal"`         | A compact notification with less padding and decoration.                                   |
-- | `"simple"`          | A simpler layout with minimal formatting.                                                  |
-- | `"compact"`         | Tries to fit the notification into a smaller area while keeping it readable.               |
-- | `"wrapped-default"` | Like `"default"`, but wraps long lines instead of letting them overflow.                   |
-- | `"wrapped-compact"` | Compact layout with line wrapping.                                                         |
