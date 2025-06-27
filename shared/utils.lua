local config = require('config')

local utils = {}

function utils.Dbug(message)
    if config.debug then
        print('^3[DEBUG] ' .. message .. '^0')
    end
end

function utils.notify(msg, type)
    lib.notify({
        title = 'HUD',
        description = msg,
        type = type
    })
end 

return utils