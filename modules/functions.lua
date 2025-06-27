local config = require('config')

return {
    GetFuel = function(vehicle)
        if GetResourceState('ox_fuel') == 'started' then
            return Entity(vehicle).state.fuel
        end
    
        if GetResourceState('cdn-fuel') == 'started' then
            return exports["cdn-fuel"]:GetFuel(vehicle)
        end
    
        if GetResourceState('LegacyFuel') == 'started' then
            return exports["LegacyFuel"]:GetFuel(vehicle)
        end
    
        if GetResourceState('rcore_fuel') == 'started' then
            return exports["rcore_fuel"]:GetFuel(vehicle)
        end
    
        if GetResourceState('okokGasStation') == 'started' then
            return exports["okokGasStation"]:GetFuel(vehicle)
        end
    
        if GetResourceState('lc_fuel') == 'started' then
            exports["lc_fuel"]:GetFuel(vehicle)
        end
    
        if GetResourceState('BigDaddy-Fuel') == 'started' then
            return exports['BigDaddy-Fuel']:GetFuel(vehicle)
        end
    
        return GetVehicleFuelLevel(vehicle)
    end,

    GetVehHealth = function(vehicle)
        local health = GetVehicleBodyHealth(vehicle)
        return math.floor((health / 1000) * 100)
    end,

    GetVehSpped = function(vehicle)
        local speed = GetEntitySpeed(vehicle)
        if config.speedunit == 'mph' then
            return math.floor(speed * 2.236936)
        else
            return math.floor(speed * 3.6)
        end
    end,

    GetDirection = function(heading)
        heading = heading % 360
    
        if heading < 22.5 or heading >= 337.5 then 
            return "N"
        elseif heading < 67.5 then 
            return "NE"
        elseif heading < 112.5 then 
            return "E"
        elseif heading < 157.5 then 
            return "SE"
        elseif heading < 202.5 then 
            return "S"
        elseif heading < 247.5 then 
            return "SW"
        elseif heading < 292.5 then 
            return "W"
        else
            return "NW"
        end
    end,
    
    CalculateMinimap = function()
        local resolutionX, resolutionY = GetActiveScreenResolution()
        local aspectRatio = resolutionX / resolutionY
        local defaultAspectRatio = 1920 / 1080
        local minimapOffset = 0
        local safezoneSize = GetSafeZoneSize()
    
        if aspectRatio > defaultAspectRatio then
            minimapOffset = ((defaultAspectRatio - aspectRatio) / 3.6) - 0.008
        end
    
        local minimapLeft = -0.005 + minimapOffset
        local yOffset = 0.005
        local minimapBottom = 1.0 - yOffset
        local minimapWidth = 0.158
        local minimapHeight = 0.193
    
        local safezoneOffset = (1.0 - safezoneSize) * 0.5
        minimapLeft = minimapLeft + safezoneOffset
        minimapBottom = minimapBottom - safezoneOffset
    
        local pixelWidth = minimapWidth * resolutionX
        local pixelHeight = minimapHeight * resolutionY
        local pixelLeft = minimapLeft * resolutionX
        local pixelTop = (minimapBottom - minimapHeight) * resolutionY
    
        return {
            width = pixelWidth,
            height = pixelHeight,
            left = (pixelLeft / resolutionX) * 100,
            top = (pixelTop / resolutionY) * 100,
        }
    end,
    
    ToggleMinimap = function()
        local defaultAspectRatio = 1920 / 1080
        local resolutionX, resolutionY = GetActiveScreenResolution()
        local aspectRatio = resolutionX / resolutionY
        local minimapOffset = 0
    
        if aspectRatio > defaultAspectRatio then
            minimapOffset = ((defaultAspectRatio - aspectRatio) / 3.6) - 0.008
        end
    
        RequestStreamedTextureDict("squaremap", false)
    
        while not HasStreamedTextureDictLoaded("squaremap") do
            Wait(100)
        end
    
        SetMinimapClipType(0)
        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
        AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
    
        local yOffset = -0.005
    
        SetMinimapComponentPosition("minimap", "L", "B", -0.005 + minimapOffset, yOffset, 0.158, 0.183)
        SetMinimapComponentPosition("minimap_mask", "L", "B", -0.005 + minimapOffset, yOffset + 0.037, 0.142, 0.20)
        SetMinimapComponentPosition("minimap_blur", "L", "B", -0.015 + minimapOffset, yOffset + 0.062, 0.272, 0.300)
    
        SetBlipAlpha(GetNorthRadarBlip(), 0)
        SetBigmapActive(true, false)
        SetMinimapClipType(0)
        
        local timeout = 0
        while true do
            SetBigmapActive(false, false)
            if timeout >= 1000 then
                break
            else
                timeout = timeout + 500
            end
            Wait(100)
        end
    end,    
}