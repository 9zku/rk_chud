local statusThreads = require('modules.threads.status')
local vehThreads = require('modules.threads.veh')
local miscThreads = require('modules.threads.misc')
local utils = require('shared.utils')
local functions = require('modules.functions')
local seatbelt = require('modules.belt.seatbelt')
local adjustments = require('modules.threads.adjustments')

statusThreads:startStatusThread()
miscThreads:startHideThread()
miscThreads:HideMinimap()
adjustments:Load()

lib.onCache('vehicle', function(value, oldValue)
    if value then
        utils.Dbug('Player in vehicle, beginning vehicle thread - Sending vehicle state to NUI')
        DisplayRadar(true)
        functions.ToggleMinimap()
        vehThreads:startVehicleThread()
    else
        utils.Dbug('Player exited vehicle, stopping vehicle thread - Sending vehicle state to NUI')
        DisplayRadar(false)
        seatbelt:ResetBelt()
    end
end)

