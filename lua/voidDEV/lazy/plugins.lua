require("lazy").setup({
  spec = {
    { import = "voidDEV.plugins" },
    { import = "voidDEV.plugins.lsp" },

    -- { import = "voidDEV.plugins.cpp" },
  },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {},
    },
  },
})
