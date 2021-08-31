resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

client_scripts {
  "@NativeUI/NativeUI.lua",
  "client/location.lua",
  "client/main.lua",
  "client/menu.lua",
  "client/markers.lua",
}

server_scripts {
  "@mysql-async/lib/MySQL.lua",
  "server/main.lua"
}
