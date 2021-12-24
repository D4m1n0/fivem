-- Spawn player somewhere
-- Check if first spawn
-- si first spawn alors insert db
-- sinon recup de la position et spawn à l'endroit

json = require "json"

RegisterServerEvent('spawn:getPlayerSpawn')
AddEventHandler('spawn:getPlayerSpawn', function()
  local playerID = GetPlayerIdentifiers(source)[1]
  print('server')
  MySQL.Async.fetchAll("SELECT * FROM users WHERE player_id = @playerID ORDER BY id DESC",
    {["@playerID"] = playerID},
    function(result)
      if result[1] == nil then
        firstSpawn(playerID)
      else
        print('server', result[1].last_position)
        local last_position = json.decode(result[1].last_position)
        print("last_position", last_position)
        local data = {
          x= last_position.x,
          y= last_position.y,
          z= last_position.z,
        }
        TriggerClientEvent('spawn:spawnPlayer', -1, {response={message="Spawn", data=data}})
      end
  end)
end)

function firstSpawn(playerID)
  local location = {
    x = 1464.723,
    y = 1105.405,
    z = 114.3344
  }

  MySQL.Async.insert("INSERT INTO users (player_id, is_first_connection, last_position) VALUES(@playerID, 1, @location)",
  {
    ["@playerID"] = playerID,
    ["@location"] = json.encode(location),
  },
  function(result)
    TriggerClientEvent('spawn:spawnPlayer', -1, {response={message="Spawn", data=location}})
  end)
end

RegisterServerEvent('spawn:setPlayerSpawnUpdate')
AddEventHandler('spawn:setPlayerSpawnUpdate', function(location)
  updatePosition(location)
end)

function updatePosition(location)
  MySQL.Async.fetchAll("UPDATE users SET health=@health WHERE player_id=@playerID",
  {["@last_position"] = json.encode(location), ["@playerID"] = GetPlayerIdentifiers(source)[1]},
  function(result)
    TriggerClientEvent('spawn:setMessage', -1, {response={message="Update position"}})
  end)
end
