local json = require "json"

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		TriggerServerEvent('need:getNeeds')
    return
	end
end)

RegisterNetEvent('need:setNeeds')
AddEventHandler('need:setNeeds', function(e)
  needs = json.decode(e)
	health = GetEntityHealth(GetPlayerPed(-1))

	SendNUIMessage({
		type = "ui",
		display = true,
		hunger = needs.hunger,
		thirst = needs.thirst,
		health = health,
	})
end)
