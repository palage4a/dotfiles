vim.cmd [[source ~/.vimrc]]

-- improve startup time
require('impatient')

require('plugins')
require('keymaps')

function _G.reload_package(name)
    package.loaded[name] = nil
    require(name)
end

