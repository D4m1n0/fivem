resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

client_scripts {
    "@NativeUI/NativeUI.lua",
    "client/main.lua"
}

server_scripts {
  "server/main.lua",
  "@mysql-async/lib/MySQL.lua"
}
