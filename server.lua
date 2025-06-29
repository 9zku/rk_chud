---@description forked from https://github.com/IlMelons/melons_fuel/blob/main/checker.lua

local ResourceName = GetResourceMetadata(GetCurrentResourceName(), 'name', 0)

lib.versionCheck(("rk3gaming/%s"):format(ResourceName))

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    if GetCurrentResourceName() ~= ResourceName then
        print('^1[ERROR] This resource must be named rk_chud^7')
        Wait(10000)
    end
end)
