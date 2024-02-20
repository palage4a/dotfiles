vim.cmd [[source ~/.vimrc]]

require('plugins')
-- improve startup time
require('impatient')
require('keymaps')
require('options')


function _G.reload_package(name)
    package.loaded[name] = nil
    require(name)
end

