-- require "resources/HungerAndThirst/main"

RegisterServerEvent('spawn:firstPop')
AddEventHandler('spawn:firstPop', function()
  local playerID = GetPlayerIdentifiers(source)[1]
  MySQL.Async.fetchAll("SELECT * FROM users WHERE player_id = @playerID ORDER BY id DESC",
    {["@playerID"] = playerID},
    function(result)
      if result[1] == nil then
        MySQL.Async.fetchAll("INSERT INTO users (player_id, is_first_connection) VALUES(@playerID, 1)",
        {["@playerID"] = playerID},
        function(result)
          -- TODO setup character_creation script
        end)
      else
        -- TODO get last_position / personal_weapons / skin
      end
end)


RegisterServerEvent('spawn:playerSpawn')
AddEventHandler('spawn:playerSpawn', function(test)
  print("test", test)
end)

RegisterCommand("save", function(source, args)
  MySQL.Async.fetchAll("SELECT * FROM users WHERE player_id = @playerID ORDER BY id DESC",
  {["@playerID"] = GetPlayerIdentifiers(source)[1]},
  function(result)
    if result[1] == nil then
      MySQL.Async.fetchAll("INSERT INTO users (player_id) VALUES(@playerID)",
      {["@playerID"] = GetPlayerIdentifiers(source)[1]},
      function(result)
        print("test", result)
      end)
    else
      local health = {}

      MySQL.Async.fetchAll("UPDATE users SET health=@health WHERE player_id=@playerID",
      {["@health"] = json.encode(health), ["@playerID"] = GetPlayerIdentifiers(source)[1]},
      function(result)
        print("test", result)
      end)
    end
  end)
end)
