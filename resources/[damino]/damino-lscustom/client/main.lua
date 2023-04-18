-- local lscustomMenu = require "lscustom"
RegisterCommand('getEntityCoords', function(source, args)
    print(GetEntityCoords(PlayerPedId()))
end)

local location = {x=-327.002106, y=-144.811035, z= 38.059929}

local blipLocation = vector2(location.x, location.y)
local blipMap = AddBlipForCoord(location.x, location.y)

SetBlipSprite(blipMap, 446)
SetBlipDisplay(blipMap, 6)
SetBlipScale(blipMap, 0.9)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("LS Custom")
EndTextCommandSetBlipName(blipMap)


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
        -- print(Vdist2(playerCoord, locVector))

        if Vdist2(playerCoord, locVector) < 10.0 then
            DisplayHelpText("Appuyer sur E")
            -- lscustom:createMenu()
            TriggerEvent('damino:lscustom:createMenu')
            Wait(5000)
        end
    end
end)
function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end