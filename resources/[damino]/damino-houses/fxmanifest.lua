fx_version "cerulean"
games {"gta5"}
lua54 "yes"

-- shared_script "config.lua"

client_scripts {
    "@menuv/menuv.lua",

    -- "client/seatbelt.lua", -- TODO Finish this
    "client/locations.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/locations.lua",
}

-- ui_page "html/index.html"
-- files {"html/index.html", "html/index.js"}

dependencies {"menuv"}