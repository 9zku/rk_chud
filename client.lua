local statusThreads = require('modules.threads.playerStatus')
local vehThreads = require('modules.threads.vehicleState')
local miscellaneousThreads = require('modules.threads.miscellaneous')
local adjustments = require('modules.threads.adjustments')

adjustments:Load()
miscellaneousThreads:startHideThread()
miscellaneousThreads:HideMinimap()
statusThreads:startStatusThread()
vehThreads:startVehicleThread()

