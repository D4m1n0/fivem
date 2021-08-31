RegisterCommand('car', function(source, args)
    -- account for the argument not being passed
    local vehicleName = args[1] or 'adder'

    -- check if the vehicle actually exists
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        TriggerEvent('chat:addMessage', {
            args = { 'It might have been a good thing that you tried to spawn a ' .. vehicleName .. '. Who even wants their spawning to actually ^*succeed?' }
        })

        return
    end

    -- load the model
    RequestModel(vehicleName)

    -- wait for the model to load
    while not HasModelLoaded(vehicleName) do
        Wait(500) -- often you'll also see Citizen.Wait
    end

    -- get the player's position
    local playerPed = PlayerPedId() -- get the local player ped
    local pos = GetEntityCoords(playerPed) -- get the position of the local player ped

    -- create the vehicle
    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    -- set the player ped into the vehicle's driver seat
    SetPedIntoVehicle(playerPed, vehicle, -1)

    -- give the vehicle back to the game (this'll make the game decide when to despawn the vehicle)
    SetEntityAsNoLongerNeeded(vehicle)

    -- release the model
    SetModelAsNoLongerNeeded(vehicleName)

    -- tell the player
    TriggerEvent('chat:addMessage', {
  		args = { 'Woohoo! Enjoy your new ^*' .. vehicleName .. '!' }
  	})
end, false)

RegisterCommand('vehicle', function(source, args)
  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed)
  local dirtLevel = GetVehicleDirtLevel(vehicle)
  local fuelLevel = GetVehicleFuelLevel(vehicle)
  SetVehicleCurrentRpm(vehicle, 255)
  print(fuelLevel)
end)


RegisterCommand('weapon', function(source, args)
  local weapon = args[1] or 'adder'

  if not IsWeaponValid(weapon) then
      TriggerEvent('chat:addMessage', {
          args = { 'There is no weapon' }
      })

      return
  end

  RequestModel(weapon)

  local playerPed = PlayerPedId()
  GiveWeaponToPed(playerPed, weapon, 1000)
  TriggerEvent('chat:addMessage', {
    args = { 'Woohoo! Enjoy your new ^*' .. weapon .. '!' }
  })
end, false)

local godmode
local god = false
RegisterCommand('god', function(source, args)
  local player = PlayerId()
	SetPlayerInvincible(player, not god)
  god = not god
  print(GetPlayerInvincible(player))
end, false)

RegisterCommand('respawn', function(source, args)
  local playerPed = PlayerPedId()
  local pos = GetEntityCoords(playerPed)
  exports.spawnmanager:setAutoSpawnCallback(function()
      -- spawnmanager has said we should spawn, let's spawn!
      exports.spawnmanager:spawnPlayer({
          -- this argument is basically a table containing the spawn location...
          x = pos.x,
          y = pos.y,
          z = pos.z,
          -- ... and the model to spawn as.
          model = 'a_m_m_skater_01'
      }, function()
          -- a callback to be called once the player is spawned in and the game is visible
          -- in this case, we just send a message to the local chat box.
          TriggerEvent('chat:addMessage', {
              args = { 'Welcome to the party!~' }
          })
      end)
  end)

  -- enable auto-spawn
  exports.spawnmanager:setAutoSpawn(true)

  -- and force respawn when the game type starts
  exports.spawnmanager:forceRespawn()
end, false)

function teleportToWayPoint()
  local playerPed =  GetPlayerPed(-1)
  local waypoint = GetFirstBlipInfoId(8)
  if DoesBlipExist(waypoint) then
    local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypoint, Citizen.ResultAsVector())
    if IsPedInAnyVehicle(playerPed, 0) then
      SetEntityCoords(GetVehiclePedIsIn(playerPed), coord, 1, 0, 0, 1)
    else
      SetEntityCoords(playerPed, coord, 1, 0, 0, 1)
    end
    drawNotification("~g~Teleported To Waypoint!")
  else
    drawNotification("~r~No Waypoint Set!")
  end
end

function revivePed(ped)
	local playerPos = GetEntityCoords(ped, true)
	isDead = false
	timerCount = reviveWait
	NetworkResurrectLocalPlayer(playerPos, true, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
end
