local statusThreads = require('modules.threads.status')
local vehThreads = require('modules.threads.veh')
local miscellaneousThreads = require('modules.threads.miscellaneous')
local adjustments = require('modules.threads.adjustments')

adjustments:Load()
miscellaneousThreads:startHideThread()
miscellaneousThreads:HideMinimap()
statusThreads:startStatusThread()
vehThreads:startVehicleThread()

