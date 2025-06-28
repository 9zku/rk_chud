local statusThreads = require('modules.threads.status')
local vehThreads = require('modules.threads.veh')
local miscThreads = require('modules.threads.misc')
local adjustments = require('modules.threads.adjustments')

statusThreads:startStatusThread()
miscThreads:startHideThread()
miscThreads:HideMinimap()
adjustments:Load()
vehThreads:startVehicleThread()

