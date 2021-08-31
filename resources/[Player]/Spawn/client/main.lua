RegisterNetEvent("output")
AddEventHandler("output", function(argument)
  TriggerEvent("chatMessage", "[Success]", {0,255,0}, argument)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if NetworkIsSessionStarted() then
			TriggerServerEvent('spawn:firstPop')
			return
		end
	end
end)
