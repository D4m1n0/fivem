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

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(60)
    local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 15.0, 0, 70)
    print("vehicle", vehicle)
    if vehicle then
      if DoesEntityExist(vehicle) then
        DisplayHelpText("Appuyer sur L")
        if IsControlPressed(1, 182) then
          -- check si plaque du véhicule est dans le trousseau de clé du joueur
          SetVehicleDoorsLocked(vehicle, 1)
          if GetVehicleDoorsLockedForPlayer(vehicle, PlayerId()) then
            SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
            notify("Fermeture de la voiture")
          else
            SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), true)
            SetVehicleDoorsLockedForAllPlayers(vehicle, true)
            notify("Ouverture de la voiture")
          end
        end
      end
    end
  end
end)

function notify(message)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(message)
  DrawNotification(true, true)
end
