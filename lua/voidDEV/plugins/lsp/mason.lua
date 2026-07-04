local tools = {
  "alex",
  "bacon",
  "bandit",
  "basedpyright",
  "black",
  "clangd",
  "docker_compose_language_service",
  "docker_language_server",
  "stylua",
  "prettier",
  "ts_ls",
}

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = tools,
      })
    end,
  },
}
