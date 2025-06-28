local nui = require('modules.nui.client')
local functions = require('modules.functions')
local seatbelt = require('modules.belt.seatbelt')
local config = require('config')

local vehThreads = {}
local mainVehicleThread = nil
local seatbeltControlThread = nil

function vehThreads:startVehicleThread()
    if mainVehicleThread then return end 
    
    mainVehicleThread = CreateThread(function()
        local wasInVehicle = false
        
        while true do
            local ped = PlayerPedId()
            local isInVehicle = IsPedInAnyVehicle(ped, false)
            
            if isInVehicle then
                local vehicle = GetVehiclePedIsIn(ped, false)
                
                if DoesEntityExist(vehicle) then
                    if not wasInVehicle then
                        DisplayRadar(true)
                        functions.ToggleMinimap()
                        wasInVehicle = true
                        self:startSeatbeltThread()
                    end
                    
                    local speed = functions.GetVehSpped(vehicle)
                    local fuel = functions.GetFuel(vehicle)
                    local rpm = GetVehicleCurrentRpm(vehicle)
                    local health = functions.GetVehHealth(vehicle)
                    local seatbeltOn = seatbelt.GetbeltState()
                    
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
                end
            else
                if wasInVehicle then
                    DisplayRadar(false)
                    seatbelt:ResetBelt()
                    wasInVehicle = false
                    
                    nui:message('setVehicleState', { 
                        inVehicle = false,
                    })
                end
            end
            
            Wait(350) 
        end
    end)
end

function vehThreads:startSeatbeltThread()
    if seatbeltControlThread then return end
    
    seatbeltControlThread = CreateThread(function()
        while IsPedInAnyVehicle(PlayerPedId(), false) do
            local seatbeltOn = seatbelt.GetbeltState()
            
            if seatbeltOn and config.DisableExitWithBelt then
                DisableControlAction(0, 23, true) 
                DisableControlAction(0, 47, true) 
                DisableControlAction(0, 58, true) 
                DisableControlAction(0, 75, true) 
            end
            
            Wait(50)
        end
        seatbeltControlThread = nil
    end)
end

return vehThreads
