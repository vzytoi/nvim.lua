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
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\21plugins.gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\gitsigns.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\15plugins.ll\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lualine.nvim"
  },
  ["nest.nvim"] = {
    config = { "\27LJ\2\n(\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\rmappings\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nest.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\vactive\2\rcheck_ts\2\nsetup\19nvim-autopairs\frequire\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\nvim-autopairs"
  },
  ["nvim-comment"] = {
    config = { "\27LJ\2\n^\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\25update_commentstring&ts_context_commentstring.internal\frequire^\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0003\3\4\0=\3\5\2B\0\2\1K\0\1\0\thook\0\1\0\1\18comment_empty\1\nsetup\17nvim_comment\frequire\0" },
    load_after = {
      ["nvim-ts-context-commentstring"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\nvim-comment"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-ts-context-commentstring", "nvim-treesitter-textsubjects", "nvim-treesitter-textobjects", "nvim-autopairs" },
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.treesitter\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\nvim-treesitter-textobjects"
  },
  ["nvim-treesitter-textsubjects"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\nvim-treesitter-textsubjects"
  },
  ["nvim-ts-context-commentstring"] = {
    after = { "nvim-comment" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim"
  },
  ["targets.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\targets.vim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\2\n³\2\0\0\b\0\21\0\0266\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\19\0005\4\5\0005\5\4\0=\5\6\0045\5\f\0005\6\b\0009\a\a\0=\a\t\0069\a\n\0=\a\v\6=\6\r\0055\6\15\0009\a\14\0=\a\16\6=\6\17\5=\5\18\4=\4\20\3B\1\2\1K\0\1\0\rdefaults\1\0\0\rmappings\6n\n<Esc>\1\0\0\nclose\6i\1\0\0\n<c-j>\24move_selection_next\n<c-k>\1\0\0\28move_selection_previous\25file_ignore_patterns\1\0\1\18prompt_prefix\a> \1\2\0\0\v.git/*\nsetup\14telescope\22telescope.actions\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    commands = { "ToggleTerm" },
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\17plugins.term\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\toggleterm.nvim"
  },
  ["trim.nvim"] = {
    config = { "\27LJ\2\n½\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\rpatterns\1\5\0\0\16%s/\\s\\+$//e\25%s/\\($\\n\\s*\\)\\+\\%$//\17%s/\\%^\\n\\+//\24%s/\\(\\n\\n\\)\\n\\+/\\1/\fdisable\1\0\0\1\5\0\0\ttext\tjson\15javascript\bcss\nsetup\ttrim\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\trim.nvim"
  },
  ["vim-MvVis"] = {
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-MvVis"
  },
  ["vim-cool"] = {
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-cool"
  },
  ["vim-fugitive"] = {
    commands = { "G", "Gdiff" },
    loaded = false,
    needs_bufread = true,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-fugitive"
  },
  ["vim-sneak"] = {
    keys = { { "", "S" }, { "", "s" } },
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-sneak"
  },
  ["vim-surround"] = {
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Cyprien\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nest.nvim
time([[Config for nest.nvim]], true)
try_loadstring("\27LJ\2\n(\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\rmappings\frequire\0", "config", "nest.nvim")
time([[Config for nest.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\15plugins.ll\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: coc.nvim
time([[Config for coc.nvim]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.coc\frequire\0", "config", "coc.nvim")
time([[Config for coc.nvim]], false)
-- Conditional loads
time("Condition for { 'gitsigns.nvim' }", true)
if
try_loadstring("\27LJ\2\nL\0\0\3\0\4\1\v6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\b\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\t.git\16isdirectory\afn\bvim\2\0", "condition", '{ "gitsigns.nvim" }')
then
time("Condition for { 'gitsigns.nvim' }", false)
time([[packadd for gitsigns.nvim]], true)
		vim.cmd [[packadd gitsigns.nvim]]
	time([[packadd for gitsigns.nvim]], false)
	-- Config for: gitsigns.nvim
	time([[Config for gitsigns.nvim]], true)
	try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\21plugins.gitsigns\frequire\0", "config", "gitsigns.nvim")
	time([[Config for gitsigns.nvim]], false)
else
time("Condition for { 'gitsigns.nvim' }", false)
end

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ToggleTerm lua require("packer.load")({'toggleterm.nvim'}, { cmd = "ToggleTerm", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file G lua require("packer.load")({'vim-fugitive'}, { cmd = "G", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Gdiff lua require("packer.load")({'vim-fugitive'}, { cmd = "Gdiff", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> s <cmd>lua require("packer.load")({'vim-sneak'}, { keys = "s", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> S <cmd>lua require("packer.load")({'vim-sneak'}, { keys = "S", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufWritePre * ++once lua require("packer.load")({'trim.nvim'}, { event = "BufWritePre *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'gitsigns.nvim', 'vim-MvVis', 'nvim-treesitter', 'targets.vim', 'vim-surround'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'nvim-web-devicons', 'vim-cool'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
