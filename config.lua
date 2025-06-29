return {
    debug = false, -- the debug in this resource is very minimal, so it's not really useful.

    framework = 'esx', -- Supported Frameworks: esx, ox, qb, qbx, standalone, custom. (For custom you must create your own bridge.)

    seatbelt = 'default', -- Options: 'default' (built-in logic), 'esx' (esx_cruisecontrol), 'qbx' (qbx_seatbelt), or 'qb' (qb-smallresources)

    speedunit = 'mph', -- mph or kph.

    ShouldHudHide = true, -- Should the hud hide when pause menu/inventory is active? INVENTORY ONLY WORKS IF ITS OX! 
    
    DisableExitWithBelt = true, -- Should F/Exiting vehicles be disabled when a seatbelt is on?

    -- Removes certain GTA:V hud components. This part was forked from https://github.com/esx-framework/esx_core/blob/main/%5Bcore%5D/es_extended/client/modules/adjustments.lua
    RemoveHudComponents = {
        [1] = false, -- WANTED_STARS,
        [2] = false, -- WEAPON_ICON
        [3] = false, -- CASH
        [4] = false, -- MP_CASH
        [5] = false, -- MP_MESSAGE
        [6] = true, -- VEHICLE_NAME
        [7] = true, -- AREA_NAME
        [8] = true, -- VEHICLE_CLASS
        [9] = true, -- STREET_NAME
        [10] = false, -- HELP_TEXT
        [11] = false, -- FLOATING_HELP_TEXT_1
        [12] = false, -- FLOATING_HELP_TEXT_2
        [13] = false, -- CASH_CHANGE
        [14] = false, -- Crosshair
        [15] = false, -- SUBTITLE_TEXT
        [16] = false, -- RADIO_STATIONS
        [17] = false, -- SAVING_GAME,
        [18] = false, -- GAME_STREAM
        [19] = false, -- WEAPON_WHEEL
        [20] = false, -- WEAPON_WHEEL_STATS
        [21] = false, -- HUD_COMPONENTS
        [22] = false -- HUD_WEAPONS
    }
}
