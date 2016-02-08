-- needs:
--      application
--      hotkey
--      fnutils
--      geometry
--      screen
--      keycodes

-- Modules
local application = require 'mjolnir.application'
local hotkey      = require 'mjolnir.hotkey'
local fnutils     = require 'mjolnir.fnutils'
local window      = require 'mjolnir.window'
local tiling      = require 'mjolnir.tiling'
local battery     = require 'mjolnir._asm.sys.battery'
local bluetooth   = require 'mjolnir._asm.undocumented.bluetooth'

-- Local Scripts
require 'tiling/layouts'


hotkey.bind({'cmd'}, 'l', function()
    local win = window.focusedwindow()
    local f = win:frame()
    f.x = f.x + 100
    win:setframe(f)
end)


local mash = {'ctrl', 'cmd'}

hotkey.bind({'cmd'}, 'h', function()
end)

hotkey.bind({'cmd'}, 'l', function()
end)

hotkey.bind(mash, 'l', function() tiling.cyclelayout() end)
hotkey.bind(mash, 'j', function() tiling.cycle(1) end)
hotkey.bind(mash, 'k', function() tiling.cycle(-1) end)
hotkey.bind(mash, 'h', function() tiling.promote() end)

-- If you want to set the layouts that are enabled
tiling.set('layouts', {
    'fullscreen',
    'main-vertical',
    'term-vim-vertical'
})
