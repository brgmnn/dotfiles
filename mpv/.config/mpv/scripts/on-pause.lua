--      On Pause Change
-- When playback is paused exit full screen mode. Then resume back to fullscreen
-- mode when playing again if we were previously in fullscreen whilst playing.

local was_fullscreen = false

mp.observe_property("pause", "bool", function(name, value)
    if value then
        was_fullscreen = mp.get_property_bool("fullscreen")
        mp.set_property("fullscreen", "no")
    elseif not value and was_fullscreen then
        mp.set_property("fullscreen", "yes")
    end
end)

