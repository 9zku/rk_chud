local config = require("config")
local utils = require("shared.utils")

if config.framework ~= "qb" then
    return
end

local QBCore = exports["qb-core"]:GetCoreObject()

local framework = {}
local playerLoaded = false

RegisterNetEvent(
    "QBCore:Client:OnPlayerLoaded",
    function()
        playerLoaded = true
        utils.Dbug("Player Successfully Loaded - Toggling hud on.")
    end
)

function framework.getPlayerStatus()
    local player = QBCore.Functions.GetPlayerData()

    if player and player.metadata then
        return {
            hunger = math.floor(player.metadata.hunger),
            thirst = math.floor(player.metadata.thirst)
        }
    end

    return {
        hunger = 0,
        thirst = 0
    }
end

---@return boolean
function framework.isPlayerLoaded()
    return playerLoaded
end

return framework
