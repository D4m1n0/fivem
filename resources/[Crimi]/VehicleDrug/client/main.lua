json = require "json"

local locationMarker = {x= 1454.837, y= 1136.708, z= 113.350}
local oneStep = 0

-- Get coords and insert a start location into DB
RegisterCommand("setVehicleDrugLocation", function(source, args)
  local coords = GetEntityCoords(PlayerPedId())

  TriggerServerEvent('crimiVehicleDrug:setVehicleDrugInDB', coords)
end)

-- Get coords and insert an end location into DB
RegisterCommand("setVehicleDrugDelivery", function(source, args)
  local coords = GetEntityCoords(PlayerPedId())

  TriggerServerEvent('crimiVehicleDrug:setVehicleDrugInDBDelivery', coords)
end)

Citizen.CreateThread(function()
  -- Create Maria
  createPed()
  while true do
    Citizen.Wait(1)

    local playerCoord = GetEntityCoords(PlayerPedId(), false)
    local locVector = vector3(locationMarker.x, locationMarker.y, locationMarker.z)

    if Vdist2(playerCoord, locVector) < 1.5 then
      DisplayHelpText("Appuyer sur E pour lancer une mission")
      if IsControlPressed(1, 38) and oneStep == 0 then
        TriggerServerEvent('crimiVehicleDrug:getVehicleDrugMission')
        oneStep = 1
      end
    end
  end
end)

RegisterNetEvent('crimiVehicleDrug:runMission')
AddEventHandler('crimiVehicleDrug:runMission', function(result)
  notify(result.response.message)
  createVehicle(result.response.data.model, result.response.data.x, result.response.data.y, result.response.data.z, result.response.data.destination, result.response.data.id, result.response.data.price)
  SetNewWaypoint(result.response.data.x, result.response.data.y)
end)

local createVehicleLoop = 0
function createVehicle(vehicle_model, x, y, z, destination, id, price)
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
      drawMarker({x= x, y= y, z= z})
      -- Check if the player is from the same gang as the player who run the mission
      local playerCoord = GetEntityCoords(PlayerPedId(), false)
      local locVector = vector3(x, y, z)

      if Vdist2(playerCoord, locVector) < 2400.5 and createVehicleLoop == 0 then
        local model = GetHashKey(vehicle_model)
        RequestModel(model)
        while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(50)
        end

        local vehicle = CreateVehicle(model, x, y, z, GetEntityHeading(PlayerPedId()), true, false)

        playerInVehicle(vehicle, destination, id, price)
        SetEntityAsNoLongerNeeded(vehicle)
        SetModelAsNoLongerNeeded(model)
        createVehicleLoop = 1
      end
    end
  end)
end

local playerIsInVehicle = 0
local canDraw = 0
function playerInVehicle(vehicle, destination, id, price)
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
      -- Check if the player is from the same gang as the player who run the mission
      if IsPedSittingInVehicle(PlayerPedId(), vehicle) and playerIsInVehicle == 0 then
        SetNewWaypoint(destination.x, destination.y)
        playerIsInVehicle = 1
        canDraw = 1
        TriggerEvent('crimiVehicleDrug:arriveAtDestination', vehicle, destination, id, price)
      end
    end
  end)
end

local fWhile = 0
RegisterNetEvent('crimiVehicleDrug:arriveAtDestination')
AddEventHandler('crimiVehicleDrug:arriveAtDestination', function(vehicle, destination, id, price)
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
      if canDraw == 1 then
        drawMarker(destination)

        -- Every player can end the mission and get monney
        local playerCoord = GetEntityCoords(PlayerPedId(), false)
        local locVector = vector3(destination.x, destination.y, destination.z)

        local closestVehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 2.5, 0, 70)
        if Vdist2(playerCoord, locVector) < 1.5 and vehicle == closestVehicle and IsPedSittingInVehicle(PlayerPedId(), vehicle) ~= 1 then
          DisplayHelpText("Rentrer la voiture")
          if IsControlPressed(1, 38) and fWhile == 0 then
            fWhile = 1
            Citizen.SetTimeout(5000, function()
              canDraw = 0
              fWhile = 0
              SetEntityAsMissionEntity(vehicle, true, true)
              DeleteVehicle(vehicle)
              TriggerServerEvent('crimiVehicleDrug:endVehicleDrugMission', vehicle, id)
            end)
          end
        end
      end
    end
  end)
end)

RegisterCommand("giveUpMission", function(source, args)
  TriggerServerEvent('crimiVehicleDrug:giveUpMission')
end)

RegisterNetEvent('crimiVehicleDrug:setMessage')
AddEventHandler('crimiVehicleDrug:setMessage', function(result)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(result.response[1])
  DrawNotification(true, true)
end)

RegisterNetEvent('crimiVehicleDrug:endMission')
AddEventHandler('crimiVehicleDrug:endMission', function()
  playerIsInVehicle = 0
  createVehicleLoop = 0
  oneStep = 0
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

function createPed()
  local hash = GetHashKey('g_f_y_vagos_01')
  RequestModel(hash)
  while not HasModelLoaded(hash) do Citizen.Wait(0) end
  ped = CreatePed(28, hash, locationMarker.x, locationMarker.y, locationMarker.z, 180.0, true, false)
  FreezeEntityPosition(ped, true)
  SetEntityInvincible(ped, true)
  TaskWanderStandard(ped,10.0,10)
  SetBlockingOfNonTemporaryEvents(ped, true)
  TaskStartScenarioInPlace(ped, "WORLD_HUMAN_COP_IDLES", 0, true)

  RequestAnimDict("amb@world_human_hang_out_street@female_arms_crossed@base")
  TaskPlayAnim(ped,"amb@world_human_hang_out_street@female_arms_crossed@base", "base", 8.0, -8, -1, 49, 0, 0, 0, 0)
end
