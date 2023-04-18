fx_version "cerulean"
games {"gta5"}
lua54 "yes"

shared_script "config.lua"

client_scripts {
    "@menuv/menuv.lua",

    "client/main.lua",
    "client/markers.lua",
    -- "client/polyzone.lua",
    -- "client/admin_menu/*.lua",
    -- "client/mapper_menu/*.lua",
    -- "client/spectate.lua",
    -- "client/feature.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/main.lua",
    "server/markers.lua",
    -- "server/module/*.lua",
    -- "server/housing.lua",
    -- "server/feature.lua",
}

ui_page "html/index.html"
files {"html/index.html", "html/index.js"}

dependencies {"menuv"}