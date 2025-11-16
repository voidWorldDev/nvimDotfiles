return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.indentscope').setup {
      draw = { delay = 0, animation = function() return 0 end },
      symbol = '│',
    }
    require('mini.pairs').setup()
    require('mini.surround').setup()
    require('mini.comment').setup()
  end,
}