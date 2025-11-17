return {
	"xeluxee/competitest.nvim",
	dependencies = "MunifTanjim/nui.nvim",
	config = function()
		require("competitest").setup({
			testcases_use_single_file = true,
			testcases_directory = "./testcases",
			template_file = {
				cpp = "/home/great/utils/template/main.cpp",
			},
			testcases_auto_detect_storage = true,
			runner_ui = {
				viewer = {
					open_when_compilation_fails = true,
				},
			},
		})
	end,
}
