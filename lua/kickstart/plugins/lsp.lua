return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				local function qf_current_diagnostic()
					local lnum = vim.fn.line(".") - 1
					local diags = vim.diagnostic.get(event.buf, { lnum = lnum })

					if #diags == 0 then
						vim.notify("No diagnostic on this line", vim.log.levels.INFO)
						return
					end
					vim.diagnostic.setqflist({
						open = true,
						diagnostics = { diags[1] },
					})
				end

				map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
				map("gr", require("telescope.builtin").lsp_references, "Goto References")
				map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("gD", vim.lsp.buf.declaration, "Goto Declaration")

				-- error mappings
				map("<leader>ee", vim.diagnostic.open_float, "error on the particular line")
				map("en", vim.diagnostic.goto_next, "goto next error")
				map("ep", vim.diagnostic.goto_prev, "goto previous error")
				map("<leader>eq", qf_current_diagnostic, "diagnostics information on the line selected")
				map("<leader>ell", vim.diagnostic.setloclist, "to see the list of errors")
				map("<leader>elq", vim.diagnostic.setqflist, "to see the list of quick fix of errors")
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		require("mason").setup()
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			},
			ts_ls = {},
			pyright = {},
		}

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}

