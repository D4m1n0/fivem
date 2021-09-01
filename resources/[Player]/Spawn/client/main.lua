Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
      print("logging")
			TriggerServerEvent('spawn:getPlayerSpawn')
			return
		end
	end
end)

RegisterNetEvent('spawn:spawnPlayer')
AddEventHandler('spawn:spawnPlayer', function(result)
  exports.spawnmanager:setAutoSpawnCallback(function()
      exports.spawnmanager:spawnPlayer({
          x = result.response.data.x,
          y = result.response.data.y,
          z = result.response.data.z,
          model = 'a_m_m_skater_01'
      }, function()
          TriggerEvent('spawn:setMessage', {response={message="Spawn"}})
      end)
  end)

  -- enable auto-spawn
  exports.spawnmanager:setAutoSpawn(true)

  -- and force respawn when the game type starts
  exports.spawnmanager:forceRespawn()
end)

RegisterNetEvent('spawn:setMessage')
AddEventHandler('spawn:setMessage', function(result)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(result.response.message)
  DrawNotification(true, true)
end)
