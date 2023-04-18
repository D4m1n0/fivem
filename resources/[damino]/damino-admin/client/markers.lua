RegisterCommand('createHouse', function(source, args)
    local playerPed = PlayerPedId()
    local location = GetEntityCoords(playerPed)
    TriggerServerEvent('damino:marker:setHouseLocation', location)
end)

RegisterCommand('setLocation', function(source, args)
    local playerPed = PlayerPedId()
    local location = GetEntityCoords(playerPed)
    local name = args[1]
    local objectLocation = args[2]
    print(name, objectLocation)
    TriggerServerEvent('damino:marker:setObjectLocation', {location, name, objectLocation})
end)

RegisterNetEvent('damino:marker:houseCreate')
AddEventHandler('damino:marker:houseCreate', function(result)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(result.response.data)
    DrawNotification(true, true)
end)