-- Dirty money
-- Money

-- set money and dirty money
-- get money and dirty money

function spawnMoney()
  TriggerServerEvent('need:getAllMoney')
end

spawnMoney()

RegisterNetEvent('need:updateUIMoney')
AddEventHandler('need:updateUIMoney', function(money, dirtyMoney)
  SendNUIMessage({
    type = "money",
    money = money,
    dirtyMoney = dirtyMoney,
  })
end)
