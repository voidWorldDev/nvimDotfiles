return {
	"xeluxee/competitest.nvim",
	dependencies = "MunifTanjim/nui.nvim",
	config = function()
		require("competitest").setup({
			single_file_testcase = true,

			template_file = {
				cpp = "/home/great/utils/template/main.cpp", -- Correct way
			},
		})
	end,
}
