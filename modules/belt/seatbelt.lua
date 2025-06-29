--------------------------------------------------------------------------------------------
--- MAKE SURE YOU HAVE setr game_enableFlyThroughWindscreen true ADDED TO THE SERVER.CFG ---
--------------------------------------------------------------------------------------------

local config = require('config')
local utils = require('shared.utils')
local seatbelt = {}

---@return boolean | nil
function seatbelt:Togglebelt()
    if not IsPedInAnyVehicle(PlayerPedId(), false) then return end

    if config.seatbelt == 'qbx' then
        return
    end

    if config.seatbelt == 'esx' then
        return
    end

    if config.seatbelt == 'qb' then
        return
    end

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
    if config.seatbelt ~= 'qbx' and config.seatbelt ~= 'esx' and config.seatbelt ~= 'qb' then
        LocalPlayer.state.seatbelt = false
    end
end

if config.seatbelt == 'default' then
    RegisterCommand('seatbelt', function()
        seatbelt:Togglebelt()
    end, false)

    RegisterKeyMapping('seatbelt', 'Toggle Seatbelt', 'keyboard', 'B')
end

return {

    ---@return boolean
    GetbeltState = function()
        if config.seatbelt == 'qbx' then
            return (LocalPlayer.state.seatbelt or false) or (LocalPlayer.state.harness or false)
        end

        if config.seatbelt == 'esx' then
            return exports['esx_cruisecontrol']:isSeatbeltOn()
        end

        if config.seatbelt == 'qb' then
            return exports['qb-smallresources']:HasSeatbeltOn() or exports['qb-smallresources']:HasHarness()
        end

        return LocalPlayer.state.seatbelt or false
    end,

    Togglebelt = seatbelt.Togglebelt,
    ResetBelt = seatbelt.ResetBelt
}
