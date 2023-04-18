Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			TriggerServerEvent('damino:spawn:getPlayerSpawn')
			return
		end
	end
end)

RegisterNetEvent('damino:spawn:spawnPlayer')
AddEventHandler('damino:spawn:spawnPlayer', function(result)
    exports.spawnmanager:setAutoSpawnCallback(function()
        exports.spawnmanager:spawnPlayer({
            x = result.response.data.x,
            y = result.response.data.y,
            z = result.response.data.z,
            model = 'mp_m_freemode_01'
        }, function()
            local model = GetHashKey('mp_m_freemode_01')

            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(100)
            end

            SetPlayerModel(PlayerId(), model)
            SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 0)
            SetPedComponentVariation(GetPlayerPed(-1), 1, 0, 0, 0)
            SetPedComponentVariation(GetPlayerPed(-1), 2, 10, 5, 0)
            SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 0)
            SetPedComponentVariation(GetPlayerPed(-1), 4, 0, 0, 0)
            SetPedComponentVariation(GetPlayerPed(-1), 5, 0, 0, 0)
            SetPedComponentVariation(GetPlayerPed(-1), 6, 0, 0, 0)
            SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 0)
            SetPedComponentVariation(GetPlayerPed(-1), 8, 0, 0, 0)
            SetModelAsNoLongerNeeded(model)
            SetPlayerInvincible(PlayerId(), true)
            Wait(5)
        end)
    end)

    -- enable auto-spawn
    exports.spawnmanager:setAutoSpawn(true)

    -- and force respawn when the game type starts
    exports.spawnmanager:forceRespawn()
end)

RegisterNetEvent('damino:spawn:test')
AddEventHandler('damino:spawn:test', function(result)
    print('ok')
end)