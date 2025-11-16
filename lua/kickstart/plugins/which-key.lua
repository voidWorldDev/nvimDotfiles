return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'helix',
  },
  keys = {
    { '<leader>c',  group = 'code' },
    { '<leader>f',  group = 'file' },
    { '<leader>g',  group = 'git' },
    { '<leader>s',  group = 'search' },
    { '<leader>t',  group = 'toggle' },
  },
}