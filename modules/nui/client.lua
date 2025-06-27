---@diagnostic disable: duplicate-set-field, lowercase-global

local config = require('config')
local utils = require('shared.utils')
local state = {}

function state:message(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        Wait(1000)
        state:message('setConfig', {
            speedUnit = config.speedunit,
            framework = config.framework
        })
        utils.Dbug('Sending Config to NUI, Speed Unit: ' .. config.speedunit .. ' Framework: ' .. config.framework)
    end
end)

return state
