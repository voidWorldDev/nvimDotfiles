return {
  'folke/todo-comments.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
    signs = false,
  },
  keys = {
    { '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Todo' },
  },
}