json = require "json"

RegisterServerEvent('crimiCase:setCaseInDB')
AddEventHandler('crimiCase:setCaseInDB', function(location)
  local locationJSON = json.encode(location)
  MySQL.Async.execute("INSERT INTO crimi_case_location (location) VALUES (@location)",
  {["@location"] = locationJSON},
  function(result)
    if result == 1 then
      TriggerClientEvent('crimiCase:setMessage', -1, {response={"success"}})
    else
      TriggerClientEvent('crimiCase:setMessage', -1, {response={"fail"}})
    end
  end)
end)

RegisterServerEvent('crimiCase:getCaseMission')
AddEventHandler('crimiCase:getCaseMission', function(location)
  local locationJSON = json.encode(location)
  local playerID = GetPlayerIdentifiers(source)[1]
  getMission(playerID)
end)

function getMission(playerID)
  MySQL.Async.fetchAll("SELECT id FROM crimi_case_mission WHERE player_id = @player_id AND running = 1",
  {["@player_id"] = playerID},
  function(result)
    if result[1] == nil then
      getCaseLocation()
    else
      TriggerClientEvent('crimiCase:setMessage', -1, {response={"Mission en cours"}})
    end
  end)
end

function getCaseLocation()
  MySQL.Async.fetchAll("SELECT * FROM crimi_case_location WHERE id = @id",
  {["@id"] = math.random(1, 10)},
  function(resultSelect)
    if resultSelect[1] ~= nil then
      createCaseMission(resultSelect[1], playerID)
    end
  end)
end

function createCaseMission(resultLocation, playerID)
  MySQL.Async.insert("INSERT INTO crimi_case_mission (player_id, running, location) VALUES (@player_id, 1, @location)",
  {
    ["@player_id"] = playerID,
    ["@location"] = resultLocation[1].location,
  },
  function(result)
    local location = json.decode(resultLocation[1].location)
    TriggerClientEvent('crimiCase:runMission', -1, {response={"success", location.x, location.y}})
    TriggerClientEvent('crimiCase:drawMarker', -1, {response={location.x, location.y, location.z, result}})
  end)
end

RegisterServerEvent('crimiCase:endCaseMission')
AddEventHandler('crimiCase:endCaseMission', function(id)
  print("id", id)
  MySQL.Async.fetchAll("UPDATE crimi_case_mission SET running=0 WHERE id=@id",
  {["@id"] = id},
  function(result)
    print('server', result)
    if result[1] ~= nil then
      TriggerClientEvent('crimiCase:setMessage', -1, {response={"Mission en terminé"}})
    end
  end)
end)
