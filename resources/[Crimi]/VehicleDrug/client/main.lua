-- Marker
-- check si running
-- si pas running, ajouter une voiture à un endroit et un waypoint
-- quand rentre dans la voiture, ajouter waypoint de livraison
-- au waypoint, ajouter un marker
-- si en dehors de la voiture, timer 5sec et disparition de la voiture
json = require "json"

local location = {x= 1454.837, y= 1136.708, z= 113.350}
local oneStep = 0

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
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
    local playerCoord = GetEntityCoords(PlayerPedId(), false)
    local locVector = vector3(location.x, location.y, location.z)

    if Vdist2(playerCoord, locVector) < 1.5 then
      DisplayHelpText("Appuyer sur E")
      if IsControlPressed(1, 38) and oneStep == 0 then
        print("E appuyé")
        TriggerServerEvent('crimiVehicleDrug:getVehicleDrugMission')
        oneStep = 1
      end
    end
  end
end)

RegisterCommand("setVehicleDrugLocation", function(source, args)
  local coords = GetEntityCoords(PlayerPedId())

  TriggerServerEvent('crimiVehicleDrug:setVehicleDrugInDB', coords)
end)

RegisterCommand("setVehicleDrugDelivery", function(source, args)
  local coords = GetEntityCoords(PlayerPedId())

  TriggerServerEvent('crimiVehicleDrug:setVehicleDrugInDBDelivery', coords)
end)

RegisterNetEvent('crimiVehicleDrug:runMission')
AddEventHandler('crimiVehicleDrug:runMission', function(result)
  notify(result.response.message)
  createVehicle(result.response.data.model, result.response.data.x, result.response.data.y, result.response.data.z, result.response.data.destination)
  SetNewWaypoint(result.response.data.x, result.response.data.y)
end)

function createVehicle(vehicle_model, x, y, z, destination)
    local model = GetHashKey(vehicle_model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(50)
    end

    local vehicle = CreateVehicle(model, x, y, z, GetEntityHeading(PlayerPedId()), true, false)
    -- print('server vehicle', GetVehicleNumberPlateText(vehicle))
    playerInVehicle(vehicle, destination)
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(model)
end

local playerIsInVehicle = 0
function playerInVehicle(vehicle, destination)
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
      if IsPedSittingInVehicle(PlayerPedId(), vehicle) and playerIsInVehicle == 0 then
        SetNewWaypoint(destination.x, destination.y)
        playerIsInVehicle = 1
      end
    end
  end)
end

RegisterNetEvent('crimiVehicleDrug:setMessage')
AddEventHandler('crimiVehicleDrug:setMessage', function(result)
  print('message:', result.response[1])
  SetNotificationTextEntry("STRING")
  AddTextComponentString(result.response[1])
  DrawNotification(true, true)
end)

function notify(message)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(message)
  DrawNotification(true, true)
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
