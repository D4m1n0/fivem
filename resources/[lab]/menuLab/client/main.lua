json = require("json")
local position = {x= 1451.858, y= 1110.09, z= 114.334}

local menuData = {
  title= 'Test',
  fields= {
    {
        type= "item",
        title= "God",
        event= "http://menuLab/menuLab:God"
    },
    {
        type= "item",
        title= "Lancer une mission de livraison",
        event= "http://menuLab/menuLab:Delivery"
    },
    {
        type= "submenu",
        title= "Véhicule",
        event= "http://menuLab/menuLab:Vehicle",
        list= {}
    }
  }
}

function listVehicle()
  TriggerServerEvent('menuLab:getVehicleList')
end

listVehicle()

RegisterNetEvent('menuLab:listVehicle')
AddEventHandler('menuLab:listVehicle', function(result)
  menuData.fields[3].list = result
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local playerCoord = GetEntityCoords(PlayerPedId(), false)
    local locVector = vector3(position.x, position.y, position.z)

    drawMarker(position)

    if Vdist2(playerCoord, locVector) < 1.5 then
      TriggerEvent("helpText:DisplayHelpText", "Appuyer sur E")
      if IsControlJustPressed(1, 38) then
        print(json.encode(menuData.fields[3]))
        TriggerEvent('dUI:openMenu', menuData)
      end
    end
  end
end)

function drawMarker(location)
  DrawMarker(
    27,
    location.x,
    location.y,
    location.z,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.5,
    1.5,
    1.5,
    179,
    39,
    39,
    155,
    false,
    true,
    2,
    nil,
    nil,
    false
  )
end

function listVehicle()

end

RegisterNUICallback('menuLab:God', function(data, cb)
  local player = PlayerId()

  print("god", data.data)
  print("Invincible", GetPlayerInvincible(player))

  SetPlayerInvincible(player, data.data)
  print("Invincible 2", GetPlayerInvincible(player))
  SetNotificationTextEntry("STRING")
  AddTextComponentString("God")
  DrawNotification(true, true)
end)
