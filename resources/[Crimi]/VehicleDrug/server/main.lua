json = require "json"

RegisterServerEvent('crimiVehicleDrug:setVehicleDrugInDB')
AddEventHandler('crimiVehicleDrug:setVehicleDrugInDB', function(location)
  local locationJSON = json.encode(location)
  MySQL.Async.execute("INSERT INTO crimi_vehicle_drug_location (location) VALUES (@location)",
  {["@location"] = locationJSON},
  function(result)
    if result == 1 then
      TriggerClientEvent('crimiVehicleDrug:setMessage', -1, {response={"success"}})
    else
      TriggerClientEvent('crimiVehicleDrug:setMessage', -1, {response={"fail"}})
    end
  end)
end)

RegisterServerEvent('crimiVehicleDrug:setVehicleDrugInDBDelivery')
AddEventHandler('crimiVehicleDrug:setVehicleDrugInDBDelivery', function(location)
  local locationJSON = json.encode(location)
  MySQL.Async.execute("INSERT INTO crimi_vehicle_drug_destination (location) VALUES (@location)",
  {["@location"] = locationJSON},
  function(result)
    if result == 1 then
      TriggerClientEvent('crimiVehicleDrug:setMessage', -1, {response={"success"}})
    else
      TriggerClientEvent('crimiVehicleDrug:setMessage', -1, {response={"fail"}})
    end
  end)
end)

RegisterServerEvent('crimiVehicleDrug:getVehicleDrugMission')
AddEventHandler('crimiVehicleDrug:getVehicleDrugMission', function()
  local playerID = GetPlayerIdentifiers(source)[1]
  -- TODO set one mission per gang
  MySQL.Async.fetchAll("SELECT id FROM crimi_vehicle_drug_mission WHERE player_id = @player_id AND running = 1",
  {["@player_id"] = playerID},
  function(result)
    if result[1] == nil then
      getVehicleDrugLocation(playerID)
    else
      -- If mission runs, get marker
      TriggerClientEvent('crimiVehicleDrug:setMessage', -1, {response={"Mission en cours"}})
    end
  end)
end)

function getVehicleDrugLocation(playerID)
  MySQL.Async.fetchAll("SELECT * FROM crimi_vehicle_drug_location",
  {},
  function(result)
    if result[1] ~= nil then
      local randomID = math.random(1, #result)
      getVehicleDrugDestination(playerID, result[randomID].location, result[randomID].city)
    end
  end)
end

function getVehicleDrugDestination(playerID, location, city)
  if city == "North" then
    city = "South"
  else
    city = "North"
  end
  MySQL.Async.fetchAll("SELECT * FROM crimi_vehicle_drug_destination WHERE city = @city",
  {["@city"] = city},
  function(result)
    if result[1] ~= nil then
      local randomID = math.random(1, #result)
      getVehicleDrugModel(playerID, location, result[randomID].location)
    end
  end)
end

function getVehicleDrugModel(playerID, location, destination)
  MySQL.Async.fetchAll("SELECT * FROM crimi_vehicle_drug_model",
  {},
  function(result)
    if result[1] ~= nil then
      local randomID = math.random(1, #result)
      setVehicleDrugMission(playerID, location, result[randomID].model, destination, result[randomID].price)
    end
  end)
end

function setVehicleDrugMission(playerID, location, model, destination, price)
  local location = json.decode(location)
  local destination = json.decode(destination)
  MySQL.Async.insert("INSERT INTO crimi_vehicle_drug_mission (player_id, running, location, model, destination, price) VALUES (@player_id, 1, @location, @model, @destination, @price)",
  {
    ["@player_id"] = playerID,
    ["@location"] = json.encode(location),
    ["@model"] = model,
    ["@destination"] = json.encode(destination),
    ["@price"] = price
  },
  function(result)
    local data = {
      x= location.x,
      y= location.y,
      z= location.z,
      model= model,
      destination= destination,
      id= result,
      price= price
    }
    TriggerClientEvent('crimiVehicleDrug:runMission', -1, {response={message="success waypoint and waypoint", data=data}})
  end)
end

RegisterServerEvent('crimiVehicleDrug:endVehicleDrugMission')
AddEventHandler('crimiVehicleDrug:endVehicleDrugMission', function(vehicle, id)
  MySQL.Async.fetchAll("UPDATE crimi_vehicle_drug_mission SET running=0 WHERE id=@id",
  {["@id"] = id},
  function(result)
    if result ~= nil then
      TriggerClientEvent('crimiVehicleDrug:setMessage', -1, {response={"Mission terminée"}})
      TriggerClientEvent('crimiVehicleDrug:endMission', -1)
    end
  end)
end)

RegisterServerEvent('crimiVehicleDrug:giveUpMission')
AddEventHandler('crimiVehicleDrug:giveUpMission', function()
  local playerID = GetPlayerIdentifiers(source)[1]
  MySQL.Async.fetchAll("UPDATE crimi_vehicle_drug_mission SET running=0 WHERE player_id=@playerID AND running=1",
  {["@playerID"] = playerID},
  function(result)
    if result ~= nil then
      TriggerClientEvent('crimiVehicleDrug:setMessage', -1, {response={"Mission abandonnée"}})
      TriggerClientEvent('crimiVehicleDrug:endMission', -1)
    end
  end)
end)
