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
}

server_scripts {
  "server/main.lua",
  "@mysql-async/lib/MySQL.lua"
}
