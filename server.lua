local versionChecked = false

function VersionCheck()
    if versionChecked then return end

    versionChecked = true
    
    local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
    local url = 'https://raw.githubusercontent.com/rk3gaming/version_checks/main/rk_chud.txt'

    PerformHttpRequest(url, function(statusCode, response, headers)
        if statusCode == 200 and response then
            local latestVersion = response:gsub('%s+', '')

            if latestVersion ~= currentVersion then
                print('^1[UPDATE] New version available! Current: ' .. currentVersion .. ', Latest: ' .. latestVersion .. '^7')
            else
                print('^2Resource is up to date!^7')
            end
        else
            print('^3[WARNING] Failed to check for updates. Status code: ' .. (statusCode or 'unknown') .. '^7')
        end
    end, 'GET', '', {})
end

AddEventHandler('onResourceStart', function()
    VersionCheck()
end)
