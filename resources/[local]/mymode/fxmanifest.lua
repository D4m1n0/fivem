fx_version 'cerulean'
game 'gta5'

author 'An awesome dude'
description 'An awesome, but short, description'
version '1.0.0'

resource_type 'gametype' { name = 'My awesome game type!' }
resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

-- client_script "@NativeUI/NativeUI.lua"
-- client_script "MenuExample.lua"
client_script 'mymode_client.lua'
