local json = require "json"

RegisterServerEvent('need:getNeeds')
AddEventHandler('need:getNeeds', function()
  local playerID = GetPlayerIdentifiers(source)[1]
  MySQL.Async.fetchAll("SELECT health FROM users where player_id = @playerID",
  {["@playerID"] = playerID},
  function(result)
    if result[1] ~= nil then
      local health = result[1].health
      TriggerClientEvent('need:setNeeds', -1, health)
    end
  end)
end)
