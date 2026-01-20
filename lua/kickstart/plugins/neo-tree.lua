return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "\\", "<cmd>Neotree reveal toggle<cr>", desc = "Toggle Explorer" },
	},
	opts = {
		close_if_last_window = false,
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,

		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_by_name = { "node_modules", ".DS_Store", "thumbs.db" },
				always_show = { ".gitignore" },
				never_show = { ".env.local" },
			},
			follow_current_file = {
				enabled = true, -- auto-focus Neo-tree on current buffer
				leave_dirs_open = false,
			},
			group_empty_dirs = true, -- group empty folders into one node
			hijack_netrw_behavior = "open_default", -- "open_default"|"open_current"|"disabled"
			use_libuv_file_watcher = true, -- better performance on large repos
			window = {
				width = 32,
				mappings = {
					["<bs>"] = "navigate_up", -- go to parent folder
					["."] = "set_root", -- set current folder as root
					["H"] = "toggle_hidden",
					["/"] = "fuzzy_finder",
					["f"] = "filter_on_submit",
				},
			},
		},
	},
}
