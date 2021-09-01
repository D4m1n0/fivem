TriggerServerEvent('clothes:getLocationClothingShops')
RegisterNetEvent('clothes:setLocationClothingShops')
AddEventHandler('clothes:setLocationClothingShops', function(result)
  local positionMapMarker = result[0]
  local blipMap = AddBlipForCoord(positionMapMarker.x, positionMapMarker.y)
  SetBlipSprite(blipMap, 73)
  SetBlipDisplay(blipMap, 6)
  SetBlipScale(blipMap, 0.9)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Vêtement")
  EndTextCommandSetBlipName(blipMap)
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
