function textHealth(content)
    SetTextFont(1)
    SetTextProportional(0)
    SetTextScale(1.9, 1.9)
    SetTextEntry("STRING")
    AddTextComponentString(content)
    DrawText(0.5, 0.2)
end

RegisterCommand('crash', function(source, args)
local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
  SetVehicleBodyHealth(vehicle, 1.0)
end, false)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10)
    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
    textHealth(GetVehicleBodyHealth(vehicle))
  end
end)
