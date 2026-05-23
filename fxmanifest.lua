fx_version 'cerulean'
game 'gta5'

name 'd4tTarget'
author 'D4NTE'
description 'Modern interaction targeting system for d4tCore'
version '1.0.0'
lua54 'yes'

ui_page 'web/index.html'

shared_scripts {
    'shared/config.lua',
    'shared/modules/*.lua'
}

client_scripts {
    'client/modules/*.lua'
}

server_scripts {
    'server/modules/*.lua'
}

files {
    'web/index.html',
    'web/style.css',
    'web/app.js'
}

dependencies {
    'd4tCore'
}
