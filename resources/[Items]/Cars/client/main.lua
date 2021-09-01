RegisterNetEvent("vehicle:spawnVehicle")
AddEventHandler('vehicle:spawnVehicle', function(vehicle_model)
    local model = GetHashKey(vehicle_model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(50)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(model, x + 2, y + 2, z + 1, GetEntityHeading(PlayerPedId()), true, false)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)

    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicleName)
end)

local controlWhile = 0

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10)
    local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 1.5, 0, 70)

    if IsPedSittingInVehicle(PlayerPedId(), vehicle) and GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(PlayerPedId()) then
      DisplayHelpText("Appuyer sur G")
      if IsControlPressed(1, 183) and controlWhile == 0 then
        -- check si plaque du véhicule est dans le trousseau de clé du joueur
        controlWhile = 1
        vehicleDoorsLocked(vehicle)
      end
    end

    if vehicle then
      if DoesEntityExist(vehicle) then
        DisplayHelpText("Appuyer sur G")
        if IsControlPressed(1, 183) and controlWhile == 0 then
          -- check si plaque du véhicule est dans le trousseau de clé du joueur
          controlWhile = 1
          vehicleDoorsLocked(vehicle)
        end
      end
    end
  end
end)

function vehicleDoorsLocked(vehicle)
  SetVehicleDoorsLocked(vehicle, 1)
  if GetVehicleDoorsLockedForPlayer(vehicle, PlayerId()) then
    SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
    SetVehicleDoorsLockedForAllPlayers(vehicle, false)
    notify("Ouverture de la voiture")
    Wait(60)
    controlWhile = 0
  else
    SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), true)
    SetVehicleDoorsLockedForAllPlayers(vehicle, true)
    notify("Fermeture de la voiture")
    Wait(60)
    controlWhile = 0
  end
end

function notify(message)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(message)
  DrawNotification(true, true)
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
