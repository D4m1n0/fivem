json = require("json")

local open = false

RegisterNetEvent('dUI:openMenu')
AddEventHandler('dUI:openMenu', function(e)
  local item = e
  if not open then
    open = true
    -- print('event', item.event)
    -- TriggerServerEvent(item.event)
  	SendNUIMessage({
  		type = "open",
  		display = true,
      item = item
  	})
    controlEvent(item)
  else
    open = false
  	SendNUIMessage({
  		type = "open",
  		display = false,
  	})
  end
end)

function controlEvent(item)
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
      if IsControlJustPressed(1, 172) then
        -- UP
      	SendNUIMessage({
      		type = "navigate",
      		key = "up"
      	})
        Citizen.Wait(30)
      elseif IsControlJustPressed(1, 173) then
        -- DOWN
      	SendNUIMessage({
      		type = "navigate",
      		key = "down"
      	})
        Citizen.Wait(30)
      elseif IsControlJustPressed(1, 174) then
        -- LEFT
      elseif IsControlJustPressed(1, 175) then
        -- RIGHT
      elseif IsControlJustPressed(1, 176) then
        -- ENTER
        SendNUIMessage({
          type = "navigate",
          key = "enter",
          item = item
        })
        Citizen.Wait(60)
      end
    end
  end)
end

RegisterNetEvent('dUI:closeMenu')
AddEventHandler('dUI:closeMenu', function(e)
  local item = e
	SendNUIMessage({
		type = "open",
		display = false,
	})
end)

RegisterNUICallback('dUI:eventServerMenu', function(data, cb)
  TriggerServerEvent(data.event, data.data)
end)
