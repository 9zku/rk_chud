---@description forked from https://github.com/esx-framework/esx_core/blob/main/%5Bcore%5D/es_extended/client/modules/adjustments.lua

local config = require('config')

Adjustments = {}

function Adjustments:RemoveHudComponents()
    for i = 1, #config.RemoveHudComponents do
        if config.RemoveHudComponents[i] then
            SetHudComponentSize(i, 0.0, 0.0)
            SetHudComponentPosition(i, 900, 900)
        end
    end
end

function Adjustments:Load()
    self:RemoveHudComponents()
    -- self:DisableAimAssist()
    -- self:DisableNPCDrops()
    -- self:SeatShuffle()
    -- self:HealthRegeneration()
    -- self:AmmoAndVehicleRewards()
    -- self:EnablePvP()
    -- self:DispatchServices()
    -- self:NPCScenarios()
    -- self:LicensePlates()
    -- self:DiscordPresence()
    -- self:WantedLevel()
    -- self:DisableRadio()
end

return Adjustments