-- lua/plugins/lspconfig.lua
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp", -- optional, only if you use nvim-cmp
  },
  config = function()
    local lspconfig = require("lspconfig")

    ---------------------------------------------------------------------
    -- Capabilities (adds nvim-cmp completion support if installed)
    ---------------------------------------------------------------------
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if ok_cmp then
      capabilities = cmp_lsp.default_capabilities(capabilities)
    end

    ---------------------------------------------------------------------
    -- on_attach: keymaps and buffer-local settings
    ---------------------------------------------------------------------
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }

      local map = vim.keymap.set
      map("n", "gd", vim.lsp.buf.definition, opts)
      map("n", "gD", vim.lsp.buf.declaration, opts)
      map("n", "gi", vim.lsp.buf.implementation, opts)
      map("n", "gr", vim.lsp.buf.references, opts)
      map("n", "K", vim.lsp.buf.hover, opts)
      map("n", "<leader>rn", vim.lsp.buf.rename, opts)
      map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      map("n", "<leader>D", vim.lsp.buf.type_definition, opts)
      map("n", "<leader>d", vim.diagnostic.open_float, opts)
      map("n", "[d", vim.diagnostic.goto_prev, opts)
      map("n", "]d", vim.diagnostic.goto_next, opts)
      map("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)

      -- Highlight symbol under cursor if supported
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end

    ---------------------------------------------------------------------
    -- Diagnostics UI
    ---------------------------------------------------------------------
    vim.diagnostic.config({
      virtual_text = { prefix = "●" },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = { border = "rounded" },
    })

    local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    ---------------------------------------------------------------------
    -- Per-server overrides
    ---------------------------------------------------------------------
    local server_opts = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      },
      clangd = {
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      },
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
      -- add other server-specific opts here as needed
    }
  end,
}
