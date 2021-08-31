local json = require("json")

RegisterServerEvent('lscustoms:getLocationLSCustoms')
AddEventHandler('lscustoms:getLocationLSCustoms', function()
  MySQL.Async.fetchAll("SELECT position_map_marker FROM ls_customs ORDER BY id DESC",
  {},
  function(result)
    local i = 1
    local locationLSCustoms = {}
    while result[i] ~= nil do
      local positionMapMarker = json.decode(result[i]["position_map_marker"])
      locationLSCustoms[i-1] = vector2(positionMapMarker.x, positionMapMarker.y)
      i = i + 1
    end
    TriggerClientEvent('lscustoms:setLocationLSCustoms', -1, locationLSCustoms)
  end)
end)

RegisterServerEvent('lscustoms:getLSCustoms')
AddEventHandler('lscustoms:getLSCustoms', function()
  MySQL.Async.fetchAll("SELECT * FROM ls_customs ORDER BY id DESC",
  {},
  function(result)
    local i = 1
    local LSCustoms = {}
    while result[i] ~= nil do
      LSCustoms[i-1] = {
        ["position"]= json.decode(result[i]["position"]),
        ["scale"]= result[i]["scale"],
      }
      i = i + 1
    end
    TriggerClientEvent('lscustoms:setLSCustoms', -1, LSCustoms)
    -- TriggerClientEvent('lscustoms:setMarkersIntoShops', -1, clothingShop)
  end)
end)
