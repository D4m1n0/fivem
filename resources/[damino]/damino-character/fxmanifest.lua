fx_version "cerulean"
games {"gta5"}
lua54 "yes"

-- shared_script "config.lua"

client_scripts {
    "@menuv/menuv.lua",

    "client/main.lua",
    "client/spawn.lua",
    "client/animations.lua",
    "client/nowanted.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/main.lua",
    "server/spawn.lua"
}

ui_page "html/index.html"
files {"html/index.html", "html/index.js"}

dependencies {"menuv"}