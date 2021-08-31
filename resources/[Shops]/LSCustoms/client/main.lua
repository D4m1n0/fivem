TriggerServerEvent('lscustoms:getLocationLSCustoms')
RegisterNetEvent('lscustoms:setLocationLSCustoms')
AddEventHandler('lscustoms:setLocationLSCustoms', function(result)
  local positionMapMarker = result[0]
  local blipMap = AddBlipForCoord(positionMapMarker.x, positionMapMarker.y)
  SetBlipSprite(blipMap, 402)
  SetBlipDisplay(blipMap, 6)
  SetBlipScale(blipMap, 0.9)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("LS Custom")
  EndTextCommandSetBlipName(blipMap)
end)

RegisterCommand("coords", function(source, args)
  local coords = GetEntityCoords(PlayerPedId())
  print(coords)
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
