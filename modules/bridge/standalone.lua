local config = require('config')

if config.framework ~= 'standalone' then return end

local framework = {}
local playerLoaded = false

AddEventHandler('PlayerSpawned', function()
    playerLoaded = true
end)

function framework.getPlayerStatus()
    return {
        hunger = 0, -- Disabled
        thirst = 0  -- Disabled
    }
end

---@return boolean
function framework.isPlayerLoaded()
    return playerLoaded
end

return framework
