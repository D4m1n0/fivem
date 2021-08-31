TriggerServerEvent('clothes:getClothingShops')
RegisterNetEvent('clothes:setMarkersIntoShops')
AddEventHandler('clothes:setMarkersIntoShops', function(result)
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
      local i = 0
      while result[i] ~= nil do
        loc = result[i]
        DrawMarker(
          loc.marker,
          loc.position.x,
          loc.position.y,
          loc.position.z-0.75,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          loc.scale,
          loc.scale,
          loc.scale,
          loc.rgba.r,
          loc.rgba.g,
          loc.rgba.b,
          loc.rgba.a,
          false,
          true,
          2,
          nil,
          nil,
          false
        )
        i = i + 1
      end
    end
  end)
end)
