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
  getMission(playerID)
end)

function getMission(playerID)
  MySQL.Async.fetchAll("SELECT id FROM crimi_vehicle_drug_mission WHERE player_id = @player_id AND running = 1",
  {["@player_id"] = playerID},
  function(result)
    if result[1] == nil then
      getVehicleDrugLocation(playerID)
    else
      TriggerClientEvent('crimiVehicleDrug:setMessage', -1, {response={"Mission en cours"}})
    end
  end)
end

function getVehicleDrugLocation(playerID)
  MySQL.Async.fetchAll("SELECT * FROM crimi_vehicle_drug_location WHERE id = @id",
  {["@id"] = 1 },--math.random(1, 10)},
  function(result)
    if result[1] ~= nil then
      getVehicleDrugModel(playerID, result[1].location)
    end
  end)
end

function getVehicleDrugModel(playerID, location)
  MySQL.Async.fetchAll("SELECT * FROM crimi_vehicle_drug_model WHERE id = @id",
  {["@id"] = math.random(1, 2)},
  function(result)
    if result[1] ~= nil then
      getVehicleDrugDestination(playerID, location, result[1].model)
    end
  end)
end

function getVehicleDrugDestination(playerID, location, model)
  MySQL.Async.fetchAll("SELECT * FROM crimi_vehicle_drug_destination WHERE id = @id",
  {["@id"] = 1},--math.random(1, 2)},
  function(result)
    if result[1] ~= nil then
      setVehicleDrugMission(playerID, location, model, result[1].location)
    end
  end)
end

function setVehicleDrugMission(playerID, location, model, destination)
  -- set location et model
  local location = json.decode(location)
  local destination = json.decode(destination)
  MySQL.Async.insert("INSERT INTO crimi_vehicle_drug_mission (player_id, running, location, model, destination) VALUES (@player_id, 1, @location, @model, @destination)",
  {
    ["@player_id"] = playerID,
    ["@location"] = json.encode(location),
    ["@model"] = model,
    ["@destination"] = json.encode(destination)
  },
  function(result)
    local data = {
      x= location.x,
      y= location.y,
      z= location.z,
      model= model,
      destination= destination,
      id= result
    }
    TriggerClientEvent('crimiVehicleDrug:runMission', -1, {response={message="success waypoint and waypoint", data=data}})
  end)
end

RegisterServerEvent('crimiVehicleDrug:endVehicleDrugMission')
AddEventHandler('crimiVehicleDrug:endVehicleDrugMission', function(vehicle, id)
  print("logging", id)
  MySQL.Async.fetchAll("UPDATE crimi_vehicle_drug_mission SET running=0 WHERE id=@id",
  {["@id"] = id},
  function(result)
    print('server', json.encode(result))
    if result ~= nil then
      TriggerClientEvent('crimiVehicleDrug:setMessage', -1, {response={"Mission terminée"}})
    end
  end)
end)
