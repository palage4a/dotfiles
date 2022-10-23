-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

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
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/i.palagecha/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/i.palagecha/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/i.palagecha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/i.palagecha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/i.palagecha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
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
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/Users/i.palagecha/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/i.palagecha/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nK\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\18icons_enabled\1\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/Users/i.palagecha/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/Users/i.palagecha/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\nì\6\0\2\t\0!\0|6\2\0\0009\2\1\2+\3\2\0=\3\2\0026\2\0\0009\2\3\0029\2\4\2\18\4\1\0'\5\2\0'\6\5\0B\2\4\0015\2\6\0=\1\a\0026\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\v\0006\a\0\0009\a\f\a9\a\r\a9\a\14\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\15\0006\a\0\0009\a\f\a9\a\r\a9\a\16\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\17\0006\a\0\0009\a\f\a9\a\r\a9\a\18\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\19\0006\a\0\0009\a\f\a9\a\r\a9\a\20\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\21\0006\a\0\0009\a\f\a9\a\r\a9\a\22\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\23\0006\a\0\0009\a\f\a9\a\r\a9\a\24\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\25\0006\a\0\0009\a\f\a9\a\r\a9\a\26\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\27\0006\a\0\0009\a\f\a9\a\r\a9\a\28\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\29\0006\a\0\0009\a\f\a9\a\r\a9\a\30\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\31\0006\a\0\0009\a\f\a9\a\r\a9\a \a\18\b\2\0B\3\5\1K\0\1\0\15formatting\r<space>=\15references\agr\16code_action\14<space>ca\vrename\14<space>rn\20type_definition\r<space>D\19signature_help\n<C-k>\19implementation\agi\nhover\6K\15definition\agd\16declaration\bbuf\blsp\agD\6n\bset\vkeymap\vbuffer\1\0\2\vsilent\2\fnoremap\2\27v:lua.vim.lsp.omnifunc\24nvim_buf_set_option\bapi\romnifunc\6g\bvim‡\4\1\0\f\0'\0H5\0\0\0006\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\5\0006\5\1\0009\5\6\0059\5\a\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\b\0006\5\1\0009\5\6\0059\5\t\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\n\0006\5\1\0009\5\6\0059\5\v\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\f\0006\5\1\0009\5\6\0059\5\r\5\18\6\0\0B\1\5\0013\1\14\0006\2\15\0'\4\16\0B\2\2\0029\2\17\0029\2\18\0025\4\19\0=\1\20\0045\5$\0005\6\22\0005\a\21\0=\a\23\0065\a\25\0005\b\24\0=\b\26\a=\a\27\0065\a\31\0006\b\1\0009\b\28\b9\b\29\b'\n\30\0+\v\2\0B\b\3\2=\b \a=\a!\0065\a\"\0=\a#\6=\6%\5=\5&\4B\2\2\1K\0\1\0\rsettings\bLua\1\0\0\14telemetry\1\0\1\venable\1\14workspace\flibrary\1\0\0\5\26nvim_get_runtime_file\bapi\16diagnostics\fglobals\1\0\0\1\3\0\0\bvim\bbox\fruntime\1\0\0\1\0\1\fversion\vLuaJIT\14on_attach\1\0\0\nsetup\16sumneko_lua\14lspconfig\frequire\0\15setloclist\r<space>q\14goto_next\a]d\14goto_prev\a[d\15open_float\15diagnostic\r<space>e\6n\bset\vkeymap\bvim\1\0\2\fnoremap\2\vsilent\2\0" },
    loaded = true,
    path = "/Users/i.palagecha/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\ná\b\0\0\6\0\24\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0024\3\0\0=\3\f\0025\3\r\0005\4\14\0=\4\15\3=\3\16\0025\3\21\0005\4\17\0005\5\18\0=\5\15\0045\5\19\0=\5\20\4=\4\22\3=\3\23\2B\0\2\1K\0\1\0\16textobjects\vselect\1\0\0\20selection_modes\1\0\3\17@class.outer\n<c-v>\20@function.outer\6V\21@parameter.outer\6v\1\0\24\ail\16@loop.inner\aal\16@loop.outer\aif\20@function.inner\aib\17@block.inner\aid\15@rhs.inner\aaC\17@class.outer\aam\16@call.outer\aiC\17@class.inner\aac\23@conditional.outer\aic\23@conditional.inner\aim\16@call.inner\ba√º\23@conditional.outer\bi√º\23@conditional.inner\aae\17@block.outer\ais\21@statement.inner\aie\17@block.inner\aiM\17@frame.inner\aas\21@statement.outer\aaM\17@frame.outer\aai\21@parameter.outer\aaf\20@function.outer\aii\21@parameter.inner\aab\17@block.outer\aad\15@lhs.inner\1\0\3\14lookahead\2#include_surrounding_whitespace\2\venable\2\26incremental_selection\fkeymaps\1\0\4\19init_selection\bgnn\22scope_incremental\bgrc\21node_incremental\bgrn\21node_decremental\bgrm\1\0\1\venable\2\vindent\14highlight\1\0\1\venable\2\fmatchup\1\0\1\venable\2\26context_commentstring\1\0\2\venable\2\19enable_autocmd\1\21ensure_installed\1\0\1\17auto_install\2\1\6\0\0\6c\blua\ago\15javascript\15typescript\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/i.palagecha/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/i.palagecha/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/i.palagecha/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/i.palagecha/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n≥\3\0\0\a\0\23\00086\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\6\0005\4\5\0=\4\a\3=\3\b\2B\0\2\0016\0\0\0'\2\t\0B\0\2\0026\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\14\0009\5\a\0004\6\0\0B\1\5\0016\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\15\0009\5\16\0004\6\0\0B\1\5\0016\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\17\0009\5\18\0004\6\0\0B\1\5\0016\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\19\0009\5\20\0004\6\0\0B\1\5\0016\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\21\0009\5\22\0004\6\0\0B\1\5\1K\0\1\0\25lsp_document_symbols\r<space>s\19lsp_references\agr\14live_grep\r<space>/\fbuffers\r<space>b\r<space>f\6n\bset\vkeymap\bvim\22telescope.builtin\fpickers\15find_files\1\0\0\1\0\1\ntheme\rdropdown\rdefaults\1\0\0\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/i.palagecha/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tmux.nvim"] = {
    config = { "\27LJ\2\nô\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\vresize\1\0\1\31enable_default_keybindings\1\15navigation\1\0\0\1\0\1\31enable_default_keybindings\2\nsetup\ttmux\frequire\0" },
    loaded = true,
    path = "/Users/i.palagecha/.local/share/nvim/site/pack/packer/start/tmux.nvim",
    url = "https://github.com/aserowy/tmux.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\29 colorscheme tokyonight \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/i.palagecha/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/i.palagecha/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\nì\6\0\2\t\0!\0|6\2\0\0009\2\1\2+\3\2\0=\3\2\0026\2\0\0009\2\3\0029\2\4\2\18\4\1\0'\5\2\0'\6\5\0B\2\4\0015\2\6\0=\1\a\0026\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\v\0006\a\0\0009\a\f\a9\a\r\a9\a\14\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\15\0006\a\0\0009\a\f\a9\a\r\a9\a\16\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\17\0006\a\0\0009\a\f\a9\a\r\a9\a\18\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\19\0006\a\0\0009\a\f\a9\a\r\a9\a\20\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\21\0006\a\0\0009\a\f\a9\a\r\a9\a\22\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\23\0006\a\0\0009\a\f\a9\a\r\a9\a\24\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\25\0006\a\0\0009\a\f\a9\a\r\a9\a\26\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\27\0006\a\0\0009\a\f\a9\a\r\a9\a\28\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\29\0006\a\0\0009\a\f\a9\a\r\a9\a\30\a\18\b\2\0B\3\5\0016\3\0\0009\3\b\0039\3\t\3'\5\n\0'\6\31\0006\a\0\0009\a\f\a9\a\r\a9\a \a\18\b\2\0B\3\5\1K\0\1\0\15formatting\r<space>=\15references\agr\16code_action\14<space>ca\vrename\14<space>rn\20type_definition\r<space>D\19signature_help\n<C-k>\19implementation\agi\nhover\6K\15definition\agd\16declaration\bbuf\blsp\agD\6n\bset\vkeymap\vbuffer\1\0\2\vsilent\2\fnoremap\2\27v:lua.vim.lsp.omnifunc\24nvim_buf_set_option\bapi\romnifunc\6g\bvim‡\4\1\0\f\0'\0H5\0\0\0006\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\5\0006\5\1\0009\5\6\0059\5\a\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\b\0006\5\1\0009\5\6\0059\5\t\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\n\0006\5\1\0009\5\6\0059\5\v\5\18\6\0\0B\1\5\0016\1\1\0009\1\2\0019\1\3\1'\3\4\0'\4\f\0006\5\1\0009\5\6\0059\5\r\5\18\6\0\0B\1\5\0013\1\14\0006\2\15\0'\4\16\0B\2\2\0029\2\17\0029\2\18\0025\4\19\0=\1\20\0045\5$\0005\6\22\0005\a\21\0=\a\23\0065\a\25\0005\b\24\0=\b\26\a=\a\27\0065\a\31\0006\b\1\0009\b\28\b9\b\29\b'\n\30\0+\v\2\0B\b\3\2=\b \a=\a!\0065\a\"\0=\a#\6=\6%\5=\5&\4B\2\2\1K\0\1\0\rsettings\bLua\1\0\0\14telemetry\1\0\1\venable\1\14workspace\flibrary\1\0\0\5\26nvim_get_runtime_file\bapi\16diagnostics\fglobals\1\0\0\1\3\0\0\bvim\bbox\fruntime\1\0\0\1\0\1\fversion\vLuaJIT\14on_attach\1\0\0\nsetup\16sumneko_lua\14lspconfig\frequire\0\15setloclist\r<space>q\14goto_next\a]d\14goto_prev\a[d\15open_float\15diagnostic\r<space>e\6n\bset\vkeymap\bvim\1\0\2\fnoremap\2\vsilent\2\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: tmux.nvim
time([[Config for tmux.nvim]], true)
try_loadstring("\27LJ\2\nô\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\vresize\1\0\1\31enable_default_keybindings\1\15navigation\1\0\0\1\0\1\31enable_default_keybindings\2\nsetup\ttmux\frequire\0", "config", "tmux.nvim")
time([[Config for tmux.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n≥\3\0\0\a\0\23\00086\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\6\0005\4\5\0=\4\a\3=\3\b\2B\0\2\0016\0\0\0'\2\t\0B\0\2\0026\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\14\0009\5\a\0004\6\0\0B\1\5\0016\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\15\0009\5\16\0004\6\0\0B\1\5\0016\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\17\0009\5\18\0004\6\0\0B\1\5\0016\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\19\0009\5\20\0004\6\0\0B\1\5\0016\1\n\0009\1\v\0019\1\f\1'\3\r\0'\4\21\0009\5\22\0004\6\0\0B\1\5\1K\0\1\0\25lsp_document_symbols\r<space>s\19lsp_references\agr\14live_grep\r<space>/\fbuffers\r<space>b\r<space>f\6n\bset\vkeymap\bvim\22telescope.builtin\fpickers\15find_files\1\0\0\1\0\1\ntheme\rdropdown\rdefaults\1\0\0\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nK\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\18icons_enabled\1\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\29 colorscheme tokyonight \bcmd\bvim\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\ná\b\0\0\6\0\24\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0024\3\0\0=\3\f\0025\3\r\0005\4\14\0=\4\15\3=\3\16\0025\3\21\0005\4\17\0005\5\18\0=\5\15\0045\5\19\0=\5\20\4=\4\22\3=\3\23\2B\0\2\1K\0\1\0\16textobjects\vselect\1\0\0\20selection_modes\1\0\3\17@class.outer\n<c-v>\20@function.outer\6V\21@parameter.outer\6v\1\0\24\ail\16@loop.inner\aal\16@loop.outer\aif\20@function.inner\aib\17@block.inner\aid\15@rhs.inner\aaC\17@class.outer\aam\16@call.outer\aiC\17@class.inner\aac\23@conditional.outer\aic\23@conditional.inner\aim\16@call.inner\ba√º\23@conditional.outer\bi√º\23@conditional.inner\aae\17@block.outer\ais\21@statement.inner\aie\17@block.inner\aiM\17@frame.inner\aas\21@statement.outer\aaM\17@frame.outer\aai\21@parameter.outer\aaf\20@function.outer\aii\21@parameter.inner\aab\17@block.outer\aad\15@lhs.inner\1\0\3\14lookahead\2#include_surrounding_whitespace\2\venable\2\26incremental_selection\fkeymaps\1\0\4\19init_selection\bgnn\22scope_incremental\bgrc\21node_incremental\bgrn\21node_decremental\bgrm\1\0\1\venable\2\vindent\14highlight\1\0\1\venable\2\fmatchup\1\0\1\venable\2\26context_commentstring\1\0\2\venable\2\19enable_autocmd\1\21ensure_installed\1\0\1\17auto_install\2\1\6\0\0\6c\blua\ago\15javascript\15typescript\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
