---@diagnostic disable: duplicate-set-field, lowercase-global

local nui = require("modules.nui.client")
local config = require("config")

hudEnabled = true

local function toggleHud()
    hudEnabled = not hudEnabled
    if hudEnabled then
        nui:message("showHud")
    else
        nui:message("hideHud")
    end
end

exports("toggleHud", toggleHud)

RegisterCommand(
    config.command,
    function()
        toggleHud()
    end,
    false
)
