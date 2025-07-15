local config = require("config")
local utils = require("shared.utils")

if config.framework ~= "esx" then
    return
end

local framework = {}
local values = {}
local playerLoaded = false

RegisterNetEvent(
    "esx:playerLoaded",
    function()
        playerLoaded = true
        utils.Dbug("Player Successfully Loaded - Toggling hud on.")
    end
)

AddEventHandler(
    "esx_status:onTick",
    function(data)
        for i = 1, #data do
            if data[i].name == "hunger" then
                values.hunger = math.floor(data[i].percent)
            end

            if data[i].name == "thirst" then
                values.thirst = math.floor(data[i].percent)
            end
        end
    end
)

function framework.getPlayerStatus()
    return {
        hunger = values.hunger or 0,
        thirst = values.thirst or 0
    }
end

---@return boolean
function framework.isPlayerLoaded()
    return playerLoaded
end

return framework
