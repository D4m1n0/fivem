Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			TriggerServerEvent('damino:locations:getMarkerLocations')
			return
		end
	end
end)

RegisterNetEvent('damino:locations:setMarkerLocations')
AddEventHandler('damino:locations:setMarkerLocations', function(result)
    for i=1, #(result.response.data) do
        local location = vector2(result.response.data[i].x, result.response.data[i].y)
        local blipMap = AddBlipForCoord(location.x, location.y)

        SetBlipSprite(blipMap, 40)
        SetBlipDisplay(blipMap, 6)
        SetBlipScale(blipMap, 0.9)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Maison")
        EndTextCommandSetBlipName(blipMap)
    end
end)