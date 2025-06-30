local config = require('config')
local nui = require('modules.nui.client')
local utils = require('shared.utils')

local miscThreads = {}

---@description: this was kinda done shitty and looks confusing.
function miscThreads:startHideThread()
    if not config.ShouldHudHide then return end
    
    local inventoryStateBag = utils.getInventoryStateBag()
    
    CreateThread(function()
        while true do
            if IsPauseMenuActive() or LocalPlayer.state[inventoryStateBag] then
                if hudEnabled then
                    nui:message('hideHud', {}) --- Only hide the status hud if not already hidden by the user.
                end
                nui:message('hideCarHud', {}) --- Hide carhud regardless.
            else
                if hudEnabled then
                    nui:message('showHud', {}) --- Show the status hud ONLY if it wasn't hidden by the user.
                end
                nui:message('showCarHud', {}) --- Always show the carhud.
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
