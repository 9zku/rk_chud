local config = require('config')
local utils = require('shared.utils')

if config.framework ~= 'ox' then return end

local framework = {}
local values = {}
local playerLoaded = false

AddEventHandler('ox:playerLoaded', function()
	playerLoaded = true
	utils.Dbug('Player Successfully Loaded - Toggling hud on.')
end)

AddEventHandler("ox:statusTick", function(data)
	values.hunger = 100 - data.hunger
	values.thirst = 100 - data.thirst
end)

function framework.getPlayerStatus()
	return {
		hunger = values.hunger or 0,
		thirst = values.thirst or 0
	}
end

function framework.isPlayerLoaded()
	return playerLoaded
end

return framework
