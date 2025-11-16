return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'bash', 'c', 'diff', 'html', 'javascript', 'jsdoc', 'json', 'jsonc',
      'lua', 'luadoc', 'luap', 'markdown', 'markdown_inline', 'python',
      'query', 'regex', 'toml', 'tsx', 'typescript', 'vim', 'vimdoc', 'yaml',
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}