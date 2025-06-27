local config = require('config')
local nui = require('modules.nui.client')
local framework = require('modules.bridge.' .. config.framework)
local statusThreads = {}

function statusThreads:status()
    if not framework.isPlayerLoaded() then
        return
    end
    
    local ped = cache.ped
    
    local health = GetEntityHealth(ped) - 100 
    local armour = GetPedArmour(ped)
    local stamina = math.floor(GetPlayerStamina(PlayerId()))
    
    local frameworkStats = framework.getPlayerStatus() or {}
    local hunger = frameworkStats.hunger
    local thirst = frameworkStats.thirst
    
    local status = {
        health = math.max(0, math.min(100, health)),
        armour = math.max(0, math.min(100, armour)),
        hunger = math.max(0, math.min(100, hunger)),
        thirst = math.max(0, math.min(100, thirst)),
        stamina = math.max(0, math.min(100, stamina))
    }
    
    nui:message('updateStatus', status)
end

function statusThreads:startStatusThread()
    CreateThread(function()
        while true do
            self:status()
            Wait(800)
        end
    end)
end

return statusThreads