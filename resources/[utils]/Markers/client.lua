RegisterNetEvent('markers:drawMarker')
AddEventHandler("markers:drawMarker", function(location)
  DrawMarker(
    27,
    location.x,
    location.y,
    location.z,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.5,
    1.5,
    1.5,
    179,
    39,
    39,
    155,
    false,
    true,
    2,
    nil,
    nil,
    false
  )
end)

RegisterCommand('getMarker', function(source, args)
  local playerPed = PlayerPedId()
  local pos = GetEntityCoords(playerPed) 
  DrawMarker(
    27,
    pos.x, pos.y, pos.z,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 179, 39, 39, 155, false, true, 2, nil, nil, false
  )
  notify('x='..pos.x..' y='..pos.y..' z='..pos.z)
end)

function notify(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(true, true)
end