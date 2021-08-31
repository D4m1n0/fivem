local positionMapMarker = vector2(1459.931, 1134.023)
local blipMap = AddBlipForCoord(positionMapMarker.x, positionMapMarker.y)

SetBlipSprite(blipMap, 40)
SetBlipDisplay(blipMap, 6)
SetBlipScale(blipMap, 0.9)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Maison")
EndTextCommandSetBlipName(blipMap)
