local json = require("json")

RegisterServerEvent('clothes:getLocationClothingShops')
AddEventHandler('clothes:getLocationClothingShops', function()
  MySQL.Async.fetchAll("SELECT position_map_marker FROM clothing_shops ORDER BY id DESC",
  {},
  function(result)
    local i = 1
    local locationClothingShop = {}
    while result[i] ~= nil do
      local positionMapMarker = json.decode(result[i]["position_map_marker"])
      locationClothingShop[i-1] = vector2(positionMapMarker.x, positionMapMarker.y)
      i = i + 1
    end
    TriggerClientEvent('clothes:setLocationClothingShops', -1, locationClothingShop)
  end)
end)

RegisterServerEvent('clothes:getClothingShops')
AddEventHandler('clothes:getClothingShops', function()
  MySQL.Async.fetchAll("SELECT * FROM clothing_shops ORDER BY id DESC",
  {},
  function(result)
    local i = 1
    local clothingShop = {}
    while result[i] ~= nil do
      clothingShop[i-1] = {
        ["position"]= json.decode(result[i]["position"]),
        ["walk_to"]= json.decode(result[i]["walk_to"]),
        ["marker"]= result[i]["marker"],
        ["scale"]= result[i]["scale"],
        ["rgba"]= json.decode(result[i]["rgba"])
      }
      i = i + 1
    end
    TriggerClientEvent('clothes:setMenuClothingShops', -1, clothingShop)
    TriggerClientEvent('clothes:setMarkersIntoShops', -1, clothingShop)
  end)
end)
