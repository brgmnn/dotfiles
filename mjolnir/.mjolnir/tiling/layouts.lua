local tiling  = require 'mjolnir.tiling'
local fnutils = require 'mjolnir.fnutils'


-- Aligns one Window to be 2/3rds of the screen on the right.
tiling.addlayout('term-vim-vertical', function(windows)
    fnutils.each(windows, function(window)
        local wincount = #windows

        if wincount == 1 then
            return layouts['fullscreen'](windows)
        end

        for index, win in pairs(windows) do
            local frame = win:screen():frame()

            if index == 1 then
                frame.w = frame.w / 3
            else
                frame.x = frame.x + frame.w / 3
                frame.w = frame.w * 2 / 3
                frame.h = frame.h / (wincount - 1)
                frame.y = frame.y + frame.h * (index - 2)
            end

            win:setframe(frame)
        end
    end)
end)
