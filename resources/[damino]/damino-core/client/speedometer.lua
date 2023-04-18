Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local speed = (GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*3.6)
        
        if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) then
            SendNUIMessage({
                type = "speedometer",
                display = true,
                speed = speed
            })
        else
            SendNUIMessage({
                type = "speedometer",
                display = false,
                speed = speed
            })
        end
    end
end)
