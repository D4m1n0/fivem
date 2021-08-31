_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Voiture", "~b~Voiture")
_menuPool:Add(mainMenu)

function carMenu(door)
  door:AddItem(NativeUI.CreateItem("Capot", ""))
  door:AddItem(NativeUI.CreateItem("Coffre", ""))
  door:AddItem(NativeUI.CreateItem("Porte avant gauche", ""))
  door:AddItem(NativeUI.CreateItem("Porte avant droite", ""))
  door:AddItem(NativeUI.CreateItem("Porte arrière gauche", ""))
  door:AddItem(NativeUI.CreateItem("Porte arrière droite", ""))
end

function limiterMenu(limiter)
  limiter:AddItem(NativeUI.CreateItem("Off", "Retirer le limitateur"))
  limiter:AddItem(NativeUI.CreateItem("50", "50km/h"))
  limiter:AddItem(NativeUI.CreateItem("70", "70km/h"))
  limiter:AddItem(NativeUI.CreateItem("90", "90km/h"))
  limiter:AddItem(NativeUI.CreateItem("120", "120km/h"))
  limiter:AddItem(NativeUI.CreateItem("150", "150km/h"))
end

local engine = mainMenu:AddItem(NativeUI.CreateItem("Moteur", ""))
local door = _menuPool:AddSubMenu(mainMenu, "Portes")
local limiter = _menuPool:AddSubMenu(mainMenu, "Limitateur de vitesse")

mainMenu.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  local playerPed =  GetPlayerPed(-1)
  local vehicle = GetVehiclePedIsUsing(playerPed)
  if itemText == "Moteur" then
    local engineStatus = GetIsVehicleEngineRunning(vehicle)
    if vehicle ~= 0 then
    	if not engineStatus then
    		SetVehicleEngineOn(vehicle, true, false, true)
    	else
    		SetVehicleEngineOn(vehicle, false, false, true)
    	end
    end
  end
end

door.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  local playerPed =  GetPlayerPed(-1)
  local car = GetVehiclePedIsUsing(playerPed)
  if itemText == "Coffre" then
    if GetVehicleDoorAngleRatio(car, 5) > 0.0 then
      SetVehicleDoorShut(car, 5, true)
    else
      SetVehicleDoorOpen(car, 5, false, true)
    end
  elseif itemText == "Capot" then
    if GetVehicleDoorAngleRatio(car, 4) > 0.0 then
      SetVehicleDoorShut(car, 4, true)
    else
      SetVehicleDoorOpen(car, 4, false, true)
    end
  elseif itemText == "Porte avant gauche" then
    if GetVehicleDoorAngleRatio(car, 0) > 0.0 then
      SetVehicleDoorShut(car, 0, true)
    else
      SetVehicleDoorOpen(car, 0, false, true)
    end
  elseif itemText == "Porte avant droite" then
    if GetVehicleDoorAngleRatio(car, 1) > 0.0 then
      SetVehicleDoorShut(car, 1, true)
    else
      SetVehicleDoorOpen(car, 1, false, true)
    end
  elseif itemText == "Porte arrière gauche" then
    if GetVehicleDoorAngleRatio(car, 2) > 0.0 then
      SetVehicleDoorShut(car, 2, true)
    else
      SetVehicleDoorOpen(car, 2, false, true)
    end
  elseif itemText == "Porte arrière droite" then
    if GetVehicleDoorAngleRatio(car, 3) > 0.0 then
      SetVehicleDoorShut(car, 3, true)
    else
      SetVehicleDoorOpen(car, 3, false, true)
    end
  end
end

limiter.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  local playerPed =  GetPlayerPed(-1)
  local car = GetVehiclePedIsUsing(playerPed)
  if itemText == "Off" then
    SetVehicleMaxSpeed(car, 0.0)
  else
    SetVehicleMaxSpeed(car, tonumber(itemText)/3.6)
  end
end

carMenu(door)
limiterMenu(limiter)

_menuPool:RefreshIndex()
_menuPool:MouseControlsEnabled (false)
_menuPool:MouseEdgeEnabled (false)
_menuPool:ControlDisablingEnabled(false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if IsControlJustPressed(1, 166) then
          if IsPedInAnyVehicle(PlayerPedId(), false) then
            mainMenu:Visible(not mainMenu:Visible())
            if door:Visible() then
              door:Visible(false)
            end
            if limiter:Visible() then
              limiter:Visible(false)
            end
          end
        end
    end
end)
