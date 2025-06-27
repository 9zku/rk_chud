local nui = require('modules.nui.client')
local functions = require('modules.functions')
local seatbelt = require('modules.belt.seatbelt')
local config = require('config')

local vehThreads = {}
local mainVehicleThread = nil

function vehThreads:startVehicleThread()
    if mainVehicleThread then return end 
    
    mainVehicleThread = CreateThread(function()
        local lastControlCheck = 0
        
        while cache.vehicle do
            local currentTime = GetGameTimer()
            local vehicle = cache.vehicle

            local speed = functions.GetVehSpped(vehicle)
            local fuel = functions.GetFuel(vehicle)
            local rpm = GetVehicleCurrentRpm(vehicle)
            local health = functions.GetVehHealth(vehicle)
            local seatbeltOn = seatbelt.GetbeltState()
            
            local ped = cache.ped
            local coords = GetEntityCoords(ped)
            local streetName = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            local streetNameString = GetStreetNameFromHashKey(streetName)
            local location = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
            
            local heading = GetEntityHeading(ped)
            local direction = functions.GetDirection(heading)
            
            local rpmPercent = rpm > 0.3 and (rpm - 0.3) / 0.7 * 100 or 0
            
            nui:message('setVehicleState', { 
                inVehicle = true,
                speed = math.floor(speed),
                fuel = math.floor(fuel),
                rpm = math.floor(rpmPercent),
                health = health,
                seatbeltOn = seatbeltOn,
                streetName = streetNameString,
                location = location,
                direction = direction
            })
            
            if currentTime - lastControlCheck >= 50 then
                if seatbeltOn and config.DisableExitWithBelt then
                    DisableControlAction(0, 23, true) 
                    DisableControlAction(0, 47, true) 
                    DisableControlAction(0, 58, true) 
                    DisableControlAction(0, 75, true) 
                end
                lastControlCheck = currentTime
            end
            
            Wait(50) 
        end
        
        nui:message('setVehicleState', { 
            inVehicle = false,
        })
        
        mainVehicleThread = nil
    end)
end

return vehThreads