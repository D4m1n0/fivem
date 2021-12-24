json = require "json"

RegisterServerEvent('menuLab:getVehicleList')
AddEventHandler('menuLab:getVehicleList', function()
  MySQL.Async.fetchAll("SELECT id, price, name, model FROM vehicles WHERE type = 'car' AND police = 0 AND doctor = 0",
  {},
  function(result)
    if result[1] ~= nil then
      TriggerClientEvent('menuLab:listVehicle', -1, result)
    end
  end)
end)
