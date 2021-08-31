local display = true

local playerPed = PlayerPedId()
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustReleased(0, 288) then
      CancelEvent()
      SendNUIMessage({
        type = "ui",
        display = display
      })
      display = not display
    end
  end
end)
