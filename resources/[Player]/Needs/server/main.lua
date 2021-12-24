local json = require "json"

RegisterServerEvent('need:getNeeds')
AddEventHandler('need:getNeeds', function()
  local playerID = GetPlayerIdentifiers(source)[1]
  MySQL.Async.fetchAll("SELECT health FROM users where player_id = @playerID",
  {["@playerID"] = playerID},
  function(result)
    if result[1] ~= nil then
      local health = result[1].health
      print('server', health)
      TriggerClientEvent('need:setNeeds', playerID, health)
    end
  end)
end)

RegisterServerEvent('need:getAllMoney')
AddEventHandler('need:getAllMoney', function()
  local playerID = GetPlayerIdentifiers(source)[1]
  MySQL.Async.fetchAll("SELECT money, dirty_money FROM users where player_id = @playerID",
  {["@playerID"] = playerID},
  function(result)
    if result[1] ~= nil then
      local money = result[1].money
      local dirtyMoney = result[1].dirty_money
      print('server', money)
      TriggerClientEvent('need:updateUIMoney', -1, money, dirtyMoney)
    end
  end)
end)

RegisterServerEvent('need:setMoney')
AddEventHandler('need:setMoney', function(money)
  local playerID = GetPlayerIdentifiers(source)[1]
  MySQL.Async.fetchAll("UPDATE users SET money=@money WHERE id=@playerID",
  {["@playerID"] = playerID, ["@money"] = money},
  function(result)
    if result[1] ~= nil then

    end
  end)
end)

RegisterServerEvent('need:getDirtyMoney')
AddEventHandler('need:getDirtyMoney', function()
  local playerID = GetPlayerIdentifiers(source)[1]
  MySQL.Async.fetchAll("SELECT dirty_money FROM users where player_id = @playerID",
  {["@playerID"] = playerID},
  function(result)
    if result[1] ~= nil then
      local dirtyMoney = result[1].dirty_money
      print('server', dirtyMoney)
      TriggerClientEvent('need:setDirtyMoney', playerID, dirtyMoney)
    end
  end)
end)
