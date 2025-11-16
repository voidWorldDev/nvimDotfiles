return {
	"kawre/leetcode.nvim",
	build = ":LeetCode setup",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		injector = {
			["cpp"] = {
				imports = function()
					return { "#include <bits/stdc++.h>", "using namespace std;" }
				end,
			},
		},
		storage = (function()
			-- Hardcode the exact path: ~/project/cpp/leetcode
			local home_dir = vim.fn.expand("~/projects/cpp")
			local home = home_dir .. "/leetcode"
			local cache = home_dir .. "/leetcode/caches"

			-- Create directories if they don't exist
			vim.fn.mkdir(home, "p")
			vim.fn.mkdir(cache, "p")

			return { home = home, cache = cache }
		end)(),
	},
}
