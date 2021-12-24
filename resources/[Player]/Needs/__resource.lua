resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

ui_page 'html/index.html'
files {
	'html/index.html',
	'html/css/main.css',
	'html/js/main.js',
}

client_scripts {
    "client/main.lua",
    "client/removeHUD.lua",
    "client/money.lua",
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
  "server/main.lua"
}
