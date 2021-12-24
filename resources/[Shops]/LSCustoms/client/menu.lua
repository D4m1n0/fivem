_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Voiture", "~b~Voiture")
_menuPool:Add(mainMenu)

function engineItem(engine)
  for i = 1, 22, 1 do
      engine:AddItem(NativeUI.CreateItem(i, ""))
  end
end

local repair = mainMenu:AddItem(NativeUI.CreateItem("Réparer", "Réparer"))
local engine = _menuPool:AddSubMenu(mainMenu, "Moteur")
engineItem(engine)
TriggerServerEvent('lscustoms:getLSCustoms')
RegisterNetEvent('lscustoms:setLSCustoms')
AddEventHandler('lscustoms:setLSCustoms', function(result)
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      local playerCoord = GetEntityCoords(PlayerPedId(), false)
      local locVector = vector3(result[0].position.x, result[0].position.y, result[0].position.z)
      -- local locVector = vector3(-1279.302, -3374.471, 13.94016)
      -- print("logging", Vdist2(playerCoord, locVector), result[0].scale*20)
      if Vdist2(playerCoord, locVector) < result[0].scale*100 and GetVehiclePedIsIn(PlayerPedId(), false) > 0 then
        DisplayHelpText("Appuyer sur E")
        _menuPool:ProcessMenus()
        if IsControlJustPressed(1, 38) then
          mainMenu:Visible(not mainMenu:Visible())
        end
      end
    end
  end)
end)

mainMenu.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  local playerPed =  GetPlayerPed(-1)
  if itemText == "Réparer" then
    local car = GetVehiclePedIsUsing(playerPed)
    SetVehicleDirtLevel(car, 0.0)
    SetVehicleEngineHealth(car, 1000)
    SetVehicleFixed(car)
  end
end

_menuPool:RefreshIndex()
_menuPool:MouseControlsEnabled (false)
_menuPool:MouseEdgeEnabled (false)
_menuPool:ControlDisablingEnabled(false)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    DrawMarker(
      23,
      -1152.771,
      -2007.083,
      12.20538,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      15.0,
      15.0,
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
end)
