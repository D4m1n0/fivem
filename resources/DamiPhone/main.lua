local phoneModel = "prop_amb_phone"
local lPed = GetPlayerPed(-1)

Citizen.CreateThread(function()
local handsup = false
while true do
  Citizen.Wait(0)
  RequestAnimDict("cellphone@cellphone_text_in")
  if IsControlPressed(1, 172) then
    if DoesEntityExist(lPed) then
      Citizen.CreateThread(function()
        RequestAnimDict("cellphone@cellphone_text_in")
        -- CreateMobilePhone(0)
        DestroyMobilePhone()
      end)
    end
  end

  if IsControlReleased(1, 172) then
    if DoesEntityExist(lPed) then
      Citizen.CreateThread(function()
        RequestAnimDict("random@mugging3")
        while not HasAnimDictLoaded("random@mugging3") do
          Citizen.Wait(100)
        end

        if handsup then
          handsup = false
          ClearPedSecondaryTask(lPed)
        end
      end)
    end
  end
end
end)
