fx_version ( 'cerulean' )
game ( 'gta5' )

author ({ 'RK ' })
name ({ 'rk_chud' })
description ({ 'Free and Open Source HUD' })
version ({ '1.0.3' })

ui_page ({ 'build/index.html' })

files ({
    'build/**',
    'build/assets/**',
    'config.lua',
    'shared/**'
})

shared_scripts ({
    '@ox_lib/init.lua',
})

server_scripts ({
    'server.lua'
})

client_scripts ({
    'client.lua',
    'modules/functions.lua',
    'modules/**/**'
})

dependencies ({
    'ox_lib',
})

lua54 ( 'true' )
