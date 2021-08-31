-- Ajouter un marker pour démarrer mission

local location = {x=1459.931, y=1134.023, z= 113.350}
local oneStep = 0
local canDraw = 1
local fWhile = 0

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
        TriggerServerEvent('crimiCase:getCaseMission')
        oneStep = 1
        canDraw = 1
      end
    end
  end
end)

RegisterNetEvent('crimiCase:runMission')
AddEventHandler('crimiCase:runMission', function(result)
  print('message:', result.response[1])
  SetNotificationTextEntry("STRING")
  AddTextComponentString(result.response[1])
  DrawNotification(true, true)
  print("result", result.response[2], result.response[3])

  SetNewWaypoint(result.response[2], result.response[3])
end)

RegisterNetEvent('crimiCase:drawMarker')
AddEventHandler('crimiCase:drawMarker', function(result)
  local hashObject = GetHashKey('prop_box_wood03a')
  RequestModel(hashObject)
  local object = CreateObject(hashObject, result.response[1], result.response[2], result.response[3], false, false, false)
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
      if canDraw == 1 then
        DrawMarker(
          27,
          result.response[1],
          result.response[2],
          result.response[3],
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
        local locVector = vector3(result.response[1], result.response[2], result.response[3])

        if Vdist2(playerCoord, locVector) < 1.5 then
          DisplayHelpText("Appuyer sur E")
          if IsControlPressed(1, 38) and fWhile == 0 then
            print("E appuyé")
            fWhile = 1
            Citizen.SetTimeout(5000, function()
              print("Send")
              canDraw = 0
              fWhile = 0
              oneStep = 0
              DeleteObject(object)
              TriggerServerEvent('crimiCase:endCaseMission', result.response[4])
            end)
          end
        end
      end
    end
  end)
end)

RegisterCommand("setCaseLocation", function(source, args)
  local coords = GetEntityCoords(PlayerPedId())

  TriggerServerEvent('crimiCase:setCaseInDB', coords)
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('crimiCase:setMessage')
AddEventHandler('crimiCase:setMessage', function(result)
  print('message:', result.response[1])
  SetNotificationTextEntry("STRING")
  AddTextComponentString(result.response[1])
  DrawNotification(true, true)
end)

RegisterCommand('setPosition', function(source, args)
  SetNewWaypoint(args[1])
end)
