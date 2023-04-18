fx_version "cerulean"
games {"gta5"}
lua54 "yes"

-- shared_script "config.lua"

client_scripts {
    "@menuv/menuv.lua",
    "client/lscustom.lua",
    "client/main.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/main.lua",
}

ui_page "html/index.html"
files {"html/index.html", "html/main.js", "html/main.css", "html/img/perf.svg", "html/img/colours.svg", "html/img/appearance.svg", "html/img/pouet.svg"}

dependencies {"menuv"}