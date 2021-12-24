local json = require "json"

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		TriggerServerEvent('need:getNeeds')
    return
	end
end)

RegisterNetEvent('need:setNeeds')
AddEventHandler('need:setNeeds', function(e)
  local needs = json.decode(e)
	local health = GetEntityHealth(GetPlayerPed(-1))
	print("health", needs.hunger)
	SendNUIMessage({
		type = "ui",
		display = true,
		hunger = needs.hunger,
		thirst = needs.thirst,
		health = health,
	})
end)
