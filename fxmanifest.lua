fx_version 'cerulean'
game 'gta5'


name         'bs_recycling'
author       'BigSmoke07'
version '1.0.0'
repository 'https://github.com/BigSmoKe07/bs_recycling'
license      'LGPL-3.0-or-later'
description  'recycling script would enable players process recyclable materials at designated centres in the game'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

dependency 'ox_lib'

lua54 'yes'
use_experimental_fxv2_oal 'yes'
