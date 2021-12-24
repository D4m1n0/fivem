json = require "json"

RegisterServerEvent('crimiVehicle:getVehicleInDB')
AddEventHandler('crimiVehicle:getVehicleInDB', function(name)
  MySQL.Async.fetchAll("SELECT * FROM vehicles where model = @name",
  {["@name"] = name},
  function(result)
    if result[1] ~= nil then
      local model = result[1].model
      if result[1].steal == 0 then
        TriggerEvent('crimiVehicle:setVehicleCanStealInDB', name)
      else
        TriggerClientEvent('crimiVehicle:setMessage', -1, {response={"fail", 'Vehicule ' .. name .. ' déjà dans la DB~'}})
      end
    else
      TriggerEvent('crimiVehicle:setVehicleInDB', name)
    end
  end)
end)

RegisterServerEvent('crimiVehicle:setVehicleCanStealInDB')
AddEventHandler('crimiVehicle:setVehicleCanStealInDB', function(name)
  MySQL.Async.fetchAll("UPDATE vehicles SET steal=1 WHERE model=@name",
  {["@name"] = name},
  function(result)
    TriggerClientEvent('crimiVehicle:setMessage', -1, {response={"success", 'Vehicule ' .. name .. ' modifié dans la DB~'}})
  end)
end)

RegisterServerEvent('crimiVehicle:setVehicleInDB')
AddEventHandler('crimiVehicle:setVehicleInDB', function(name)
  MySQL.Async.fetchAll("INSERT INTO vehicles (steal, model) VALUES(1, @name)",
  {["@name"] = name},
  function(result)
    print('server', result)
    if result then
      TriggerClientEvent('crimiVehicle:setMessage', -1, {response={"success", 'Vehicule ' .. name .. ' ajouté dans la DB~'}})
    end
  end)
end)
