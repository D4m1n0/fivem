json = require "json"

RegisterServerEvent('admin:getGuns')
AddEventHandler('admin:getGuns', function()
  local _source = source
  MySQL.Async.fetchAll("SELECT * FROM weapons ORDER BY type ASC",
  {},
  function(result)
    local j = 1
    local weapons = {}
    for i=1, #(result) do
      if weapons[result[i]["type"]] == nil then
        weapons[result[i]["type"]] = {}
        j = 1
      end
      weapons[result[i]["type"]][j] = { ["value"]= result[i]["model"], ["label"] = result[i]["name"] }
      j = j + 1
    end
    local weaponsCategory = {}

    MySQL.Async.fetchAll("SELECT * FROM weapons_category ORDER BY type ASC",
    {},
    function(weaponCategoryResult)
      for i=1, #(weaponCategoryResult) do
        weaponsCategory[weaponCategoryResult[i]["type"]] = weaponCategoryResult[i]["name"]
      end
      TriggerClientEvent('admin:setGuns', _source, {["weapons"]=weapons, ["categories"]=weaponsCategory})
    end)
  end)
end)

RegisterServerEvent('admin:getCars')
AddEventHandler('admin:getCars', function()
  local _source = source
  MySQL.Async.fetchAll("SELECT * FROM vehicles WHERE type='car' ORDER BY sub_model ASC",
  {},
  function(result)
    local j = 1
    local cars = {}
    for i=1, #(result) do
      if cars[result[i]["sub_model"]] == nil then
        cars[result[i]["sub_model"]] = {}
        j = 1
      end
      cars[result[i]["sub_model"]][j] = { ["value"]= result[i]["model"], ["label"] = result[i]["name"] }
      j = j + 1
    end
    local carsCategory = {}

    MySQL.Async.fetchAll("SELECT * FROM vehicles_category ORDER BY type ASC",
    {},
    function(carCategoryResult)
      for i=1, #(carCategoryResult) do
        carsCategory[carCategoryResult[i]["type"]] = carCategoryResult[i]["name"]
      end
      TriggerClientEvent('admin:setCars', _source, {["cars"]=cars, ["categories"]=carsCategory})
    end)
  end)
end)

RegisterServerEvent('admin:setPersonnalVehicle')
AddEventHandler('admin:setPersonnalVehicle', function(e)
  local playerID = GetPlayerIdentifiers(source)[1]
  MySQL.Async.fetchAll("SELECT * FROM player_vehicles WHERE license='@playerID'",
  {["@playerID"] = playerID},
  function(result)
    if result == nil then
      MySQL.Async.insert("INSERT INTO player_vehicles (license, name, model, mods, plate) VALUES(@playerID, @name, @model, @mods, @plate)",
      {
          ["@playerID"] = playerID,
          ["@name"] = "NoName",
          ["@model"] = e["name"],
          ["@mods"] = json.encode(e["mods"]),
          ["@plate"] = e["plate"]
      },
      function(result)
          print("ok")
      end)
    end
  end)
end)