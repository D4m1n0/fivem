RegisterServerEvent('admin:getGuns')
AddEventHandler('admin:getGuns', function()
  MySQL.Async.fetchAll("SELECT * FROM weapons ORDER BY id DESC",
  {},
  function(result)
    local i = 1
    local weapons = {}
    while result[i] ~= nil do
      weapons[i-1] = { ["model"]= result[i]["model"], ["name"] = result[i]["name"]}
      i = i + 1
    end
    TriggerClientEvent('admin:setGuns', -1, weapons)
  end)
end)

RegisterServerEvent('admin:getCars')
AddEventHandler('admin:getCars', function()
  MySQL.Async.fetchAll("SELECT * FROM vehicles WHERE type='car' ORDER BY id DESC",
  {},
  function(result)
    local i = 1
    local cars = {}
    while result[i] ~= nil do
      cars[i-1] = { ["model"]= result[i]["model"], ["name"] = result[i]["name"]}
      i = i + 1
    end
    TriggerClientEvent('admin:setCars', -1, cars)
  end)
end)
