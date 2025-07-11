local config = require('config')

local utils = {}

---@param message string
function utils.Dbug(message)
    if config.debug then
        print('^3[DEBUG] ' .. message .. '^0')
    end
end

---@param msg string
---@param type "inform" | "success" | "error" | "warning"
function utils.notify(msg, type)
    lib.notify({
        title = 'HUD',
        description = msg,
        type = type
    })
end

---@return "inv_busy" | "invOpen"
function utils.getInventoryStateBag()
    if GetResourceState('ox_inventory') == 'started' then
        return 'invOpen'
    end

    if GetResourceState('qb-inventory') == 'started' then
        return 'inv_busy'
    end

    return 'invOpen'
end

return utils
