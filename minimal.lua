vim.cmd [[set runtimepath=$VIMRUNTIME]]
vim.cmd [[set packpath=/tmp/nvim/site]]
local package_root = '/tmp/nvim/site/pack'
local install_path = package_root .. '/packer/start/packer.nvim'

if vim.fn.isdirectory(install_path) == 0 then
  print("Installing Gitsigns and dependencies.")
  vim.fn.system { 'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', install_path }
end

-- Load plugins
require('packer').startup {
  {
    'wbthomason/packer.nvim',
    {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
    },
    -- ADD PLUGINS THAT ARE _NECESSARY_ FOR REPRODUCING THE ISSUE
  },
  config = {
    package_root = package_root,
    compile_path = install_path .. '/plugin/packer_compiled.lua',
    display = { non_interactive = true },
  },
}

_G.load_config = function()
  require('gitsigns').setup{
    debug_mode = true, -- You must add this to enable debug messages
    -- GITSIGNS CONFIG THAT ARE _NECESSARY_ FOR REPRODUCING THE ISSUE
  }

  -- ADD INIT.LUA SETTINGS THAT ARE _NECESSARY_ FOR REPRODUCING THE ISSUE

  -- ALSO INCLUDE GITSIGNS DEBUG MESSAGES
  vim.cmd('Gitsigns debug_messages')
end

require('packer').sync()

vim.cmd [[autocmd User PackerComplete ++once echo "Ready!" | lua load_config()]]
