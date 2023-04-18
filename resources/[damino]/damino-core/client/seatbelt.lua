Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local ped = GetPlayerPed(-1)
        local car = GetVehiclePedIsIn(ped, false)

        if car ~= nil then
            local speed = GetEntitySpeed(car) * 3.6 -- Convertir la vitesse en km/h
            
            if speed > 100.0 then
                local coords = GetEntityCoords(car)
                local heading = GetEntityHeading(car)
                local forward = GetEntityForwardVector(car)
                local frontCoords = coords + forward * 1.0
                
                local rayHandle = StartShapeTestCapsule(coords.x, coords.y, coords.z, frontCoords.x, frontCoords.y, frontCoords.z, 2.5, 10, car, 7)
                local _, hit, _, _, object = GetShapeTestResult(rayHandle)
                
                notify(rayHandle, hit)
                if hit == 1 and (IsEntityAVehicle(object) or IsEntityAnObject(object)) then
                    local carVelocity = GetEntityVelocity(car)
                    TriggerEvent('carCrash', car, object, speed, ped, carVelocity)
                end
            end
        end
    end
end)

RegisterNetEvent('carCrash')
AddEventHandler('carCrash', function(car, target, speed, ped, carVelocity)
    -- notify('Collision détectée entre le véhicule : '..car..' et la cible : '..target..' à une vitesse de '..speed..' km/h')
    -- notify('une vélocité de x='..carVelocity.x..' y='..carVelocity.y..' et z='..carVelocity.z)
    local position = GetOffsetFromEntityInWorldCoords(car, 1.0, 0.0, 1.0)
    SetEntityCoords(ped, position[1], position[2], position[3], false, false, false, false)
    SetPedToRagdoll(ped, 5511, 5511, 0, false, false, false)
    SetEntityVelocity(ped, carVelocity.x, carVelocity.y, carVelocity.z)
end)

function notify(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(true, true)
end