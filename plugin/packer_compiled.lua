-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "C:\\Users\\Cyprien\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\Cyprien\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\Cyprien\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\Cyprien\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\Cyprien\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["coc.nvim"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.coc\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\coc.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n^\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\ntheme\rcodedark\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lualine.nvim"
  },
  ["nest.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.mappings\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nest.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim"
  },
  ["tabnine-vim"] = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20plugins.tabnine\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\tabnine-vim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\targets.vim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n�\2\0\0\b\0\23\0\0286\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\21\0005\4\5\0005\5\4\0=\5\6\0045\5\14\0005\6\b\0009\a\a\0=\a\t\0069\a\n\0=\a\v\0069\a\f\0=\a\r\6=\6\15\0055\6\17\0009\a\16\0=\a\18\6=\6\19\5=\5\20\4=\4\22\3B\1\2\1K\0\1\0\rdefaults\1\0\0\rmappings\6n\n<Esc>\1\0\0\nclose\6i\1\0\0\n<c-j>\24move_selection_next\n<c-k>\28move_selection_previous\n<c-d>\1\0\0\18delete_buffer\25file_ignore_patterns\1\0\1\18prompt_prefix\a> \1\2\0\0\v.git/*\nsetup\14telescope\22telescope.actions\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17plugins.term\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\toggleterm.nvim"
  },
  ["trim.nvim"] = {
    config = { "\27LJ\2\na\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fdisable\1\0\0\1\4\0\0\tjson\15javascript\bcss\nsetup\ttrim\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\trim.nvim"
  },
  ["vim-MvVis"] = {
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-MvVis"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-commentary"
  },
  ["vim-cool"] = {
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-cool"
  },
  ["vim-devicons"] = {
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-devicons"
  },
  ["vim-sneak"] = {
    keys = { { "", "S" }, { "", "s" } },
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-sneak"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: coc.nvim
time([[Config for coc.nvim]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.coc\frequire\0", "config", "coc.nvim")
time([[Config for coc.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n�\2\0\0\b\0\23\0\0286\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\21\0005\4\5\0005\5\4\0=\5\6\0045\5\14\0005\6\b\0009\a\a\0=\a\t\0069\a\n\0=\a\v\0069\a\f\0=\a\r\6=\6\15\0055\6\17\0009\a\16\0=\a\18\6=\6\19\5=\5\20\4=\4\22\3B\1\2\1K\0\1\0\rdefaults\1\0\0\rmappings\6n\n<Esc>\1\0\0\nclose\6i\1\0\0\n<c-j>\24move_selection_next\n<c-k>\28move_selection_previous\n<c-d>\1\0\0\18delete_buffer\25file_ignore_patterns\1\0\1\18prompt_prefix\a> \1\2\0\0\v.git/*\nsetup\14telescope\22telescope.actions\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n^\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\ntheme\rcodedark\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17plugins.term\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: nest.nvim
time([[Config for nest.nvim]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.mappings\frequire\0", "config", "nest.nvim")
time([[Config for nest.nvim]], false)
-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> S <cmd>lua require("packer.load")({'vim-sneak'}, { keys = "S", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> s <cmd>lua require("packer.load")({'vim-sneak'}, { keys = "s", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'vim-devicons', 'tabnine-vim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufWritePre * ++once lua require("packer.load")({'trim.nvim'}, { event = "BufWritePre *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
