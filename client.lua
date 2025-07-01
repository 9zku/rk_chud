local statusThreads = require('modules.threads.status')
local vehThreads = require('modules.threads.veh')
local miscThreads = require('modules.threads.misc')
local adjustments = require('modules.threads.adjustments')

adjustments:Load()
miscThreads:startHideThread()
miscThreads:HideMinimap()
statusThreads:startStatusThread()
vehThreads:startVehicleThread()

