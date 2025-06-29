local config = require('config')
local nui = require('modules.nui.client')
local utils = require('shared.utils')

local miscThreads = {}

function miscThreads:startHideThread()
    if not config.ShouldHudHide then return end
    
    local inventoryStateBag = utils.getInventoryStateBag()
    
    CreateThread(function()
        while true do
            if IsPauseMenuActive() or LocalPlayer.state[inventoryStateBag] then
                nui:message('hideHud', {})
                nui:message('hideCarHud', {})
            else
                nui:message('showHud', {})
                nui:message('showCarHud', {})
            end
            Wait(2000)
        end
    end)
end

function miscThreads:HideMinimap()
    CreateThread(function()
        while true do
            if not cache.vehicle then
                DisplayRadar(false)
                SetRadarBigmapEnabled(false, false)
            end
            Wait(2000)
        end
    end)
end


return miscThreads
