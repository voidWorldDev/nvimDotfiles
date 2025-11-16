return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  cmd = 'Telescope',
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>' },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>' },
  },
  opts = {
    defaults = {
      layout_strategy = 'horizontal',
      layout_config = { prompt_position = 'top' },
      sorting_strategy = 'ascending',
      winblend = 0,
    },
  },
  config = function(_, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension 'fzf'
  end,
}