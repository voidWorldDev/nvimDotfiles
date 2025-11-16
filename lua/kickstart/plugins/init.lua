-- ~/.config/nvim/lua/kickstart/plugins/init.lua
-- This file makes the module valid for lazy.nvim
-- It automatically loads every *.lua file in this folder (except itself)

local plugins = {}

-- Load all plugin files in this directory
local plugin_files = vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/kickstart/plugins', function(name)
  return name ~= 'init.lua' and name:match('%.lua$')
end)

for _, file in ipairs(plugin_files) do
  local plugin_name = file:gsub('%.lua$', '')
  local plugin = require('kickstart.plugins.' .. plugin_name)
  table.insert(plugins, plugin)
end

return plugins