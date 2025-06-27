--------------------------------------------------------------------------------------------
--- MAKE SURE YOU HAVE setr game_enableFlyThroughWindscreen true ADDED TO THE SERVER.CFG ---
--------------------------------------------------------------------------------------------

local utils = require('shared.utils')
local seatbelt = {}

function seatbelt:Togglebelt()
    if not IsPedInAnyVehicle(PlayerPedId(), false) then return end

    local currentBelt = LocalPlayer.state.seatbelt or false
    local newBelt = not currentBelt
    
    LocalPlayer.state.seatbelt = newBelt

    if not newBelt then
        SetFlyThroughWindscreenParams(35.0, 40.0, 17.0, 2000.0)
        SetPedConfigFlag(PlayerPedId(), 32, true)
    else
        SetPedConfigFlag(PlayerPedId(), 32, false)
    end

    utils.notify(newBelt and 'Seatbelt fastened' or 'Seatbelt unfastened', newBelt and 'success' or 'error')

    return newBelt
end

function seatbelt:ResetBelt()
    LocalPlayer.state.seatbelt = false
end

RegisterCommand('seatbelt', function()
    seatbelt:Togglebelt()
end, false)

RegisterKeyMapping('seatbelt', 'Toggle Seatbelt', 'keyboard', 'B')

return {
    GetbeltState = function() return LocalPlayer.state.seatbelt or false end,
    Togglebelt = seatbelt.Togglebelt,
    ResetBelt = seatbelt.ResetBelt
}