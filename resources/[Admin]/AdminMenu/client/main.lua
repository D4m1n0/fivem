_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Admin Menu", "~b~Menu admin")
_menuPool:Add(mainMenu)

god = false
invisible = false

function ClickItem(menu)
   local godCheckboxItem = NativeUI.CreateCheckboxItem("God", god, "Invincible")
   menu:AddItem(godCheckboxItem)

   local teleportCheckboxItem = NativeUI.CreateItem("Teleport", "~r~Teleport to waypoint")
   menu:AddItem(teleportCheckboxItem)

   local healCheckboxItem = NativeUI.CreateItem("Heal", "~g~Heal yourself")
   menu:AddItem(healCheckboxItem)

   local reviveCheckboxItem = NativeUI.CreateItem("Revive", "~g~Revive yourself")
   menu:AddItem(reviveCheckboxItem)

   local respawnCheckboxItem = NativeUI.CreateItem("Respawn", "~r~Respawn")
   menu:AddItem(respawnCheckboxItem)

   local invisibleCheckboxItem = NativeUI.CreateCheckboxItem("Invisible", invisible, "~g~Invisible")
   menu:AddItem(invisibleCheckboxItem)

   local fullCheckboxItem = NativeUI.CreateItem("Full", "~g~Full Custom")
   menu:AddItem(fullCheckboxItem)

   local repairCheckboxItem = NativeUI.CreateItem("Repair", "~g~Repair car")
   menu:AddItem(repairCheckboxItem)

   local SkinAdminCheckboxItem = NativeUI.CreateItem("SkinAdmin", "~g~Reskin")
   menu:AddItem(SkinAdminCheckboxItem)
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    TriggerServerEvent('admin:getGuns')
    TriggerServerEvent('admin:getCars')
    return
  end
end)

RegisterNetEvent('admin:setGuns')
AddEventHandler('admin:setGuns', function(e)
  weapons = e
  function WeaponsItem(menu)
      local name_weapons = {}
      local i = 0

      while weapons[i] ~= nil do
        name_weapons[i] = weapons[i]["name"]
        i = i + 1
      end
      local gunsList = NativeUI.CreateListItem("Weapons", name_weapons, 1)
      menu:AddItem(gunsList)
  end
  WeaponsItem(mainMenu)
end)

RegisterNetEvent('admin:setCars')
AddEventHandler('admin:setCars', function(e)
  cars = e
  function CarItem(menu)
    local name_cars = {}
    local i = 0

    while cars[i] ~= nil do
      name_cars[i] = cars[i]["name"]
      i = i + 1
    end
    local carsList = NativeUI.CreateListItem("Cars", name_cars, 1)
    menu:AddItem(carsList)
  end
  CarItem(mainMenu)
end)

ClickItem(mainMenu)
_menuPool:RefreshIndex()
_menuPool:MouseControlsEnabled (false)
_menuPool:MouseEdgeEnabled (false)
_menuPool:ControlDisablingEnabled(false)

mainMenu.OnCheckboxChange = function(sender, item, checked_)
  local itemText = item.Base.Text._Text
  local player = PlayerId()
  if itemText == "God" then
    god = checked_
    SetPlayerInvincible(player, god)
    notify(tostring(god))
  elseif itemText == "Invisible" then
    invisible = checked_
    SetPlayerInvisibleLocally(player, invisible)
    local model = GetHashKey('mp_m_freemode_01')

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end

    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    notify(tostring(invisible))
  end
end

mainMenu.OnListSelect = function(send, item, index)
  local itemText = item.Base.Text._Text
  if itemText == "Weapons" then
    local selectedGun = weapons[index]["model"]
    TriggerEvent("weapons:giveWeapon", selectedGun)
    notify("spawned in a "..selectedGun)
  elseif itemText == "Cars" then
    local selectedCar = cars[index]["model"]
    TriggerEvent("vehicle:spawnVehicle", selectedCar)
    notify("spawned in a "..selectedCar)
  end
end

mainMenu.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  local playerPed =  GetPlayerPed(-1)
  if itemText == "Teleport" then
    local waypoint = GetFirstBlipInfoId(8)
    if DoesBlipExist(waypoint) then
      local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypoint, Citizen.ResultAsVector())
      if IsPedInAnyVehicle(playerPed, 0) then
        SetEntityCoords(GetVehiclePedIsIn(playerPed), coord, 1, 0, 0, 1)
      else
        SetEntityCoords(playerPed, coord, 1, 0, 0, 1)
      end
      notify("~g~Teleported To Waypoint!")
    else
      notify("~r~No Waypoint Set!")
    end
  elseif itemText == "Heal" then
    SetEntityHealth(PlayerPedId(), 200)
    notify("~g~Healed.")
  elseif itemText == "Revive" then
  	local playerPos = GetEntityCoords(playerPed, true)
  	isDead = false
  	timerCount = reviveWait
  	NetworkResurrectLocalPlayer(playerPos, true, true, false)
  	SetPlayerInvincible(playerPed, false)
  	ClearPedBloodDamage(playerPed)
    notify("~g~Revived.")
  elseif itemText == "Respawn" then
    -- local PlayerPedId = PlayerPedId()
    exports.spawnmanager:setAutoSpawnCallback(function()
        exports.spawnmanager:spawnPlayer({
            x = 1464.723,
            y = 1105.405,
            z = 114.3344,
            model = 'a_m_m_skater_01'
        }, function()
            notify("~g~Respawned.")
        end)
    end)

    -- enable auto-spawn
    exports.spawnmanager:setAutoSpawn(true)

    -- and force respawn when the game type starts
    exports.spawnmanager:forceRespawn()
  elseif itemText == "Full" then
    if IsPedInAnyVehicle(PlayerPedId(), false) then
	     local car = GetVehiclePedIsUsing(playerPed)
       SetVehicleMod(car, 11, 2)
       SetVehicleMod(car, 16, 1)
       SetVehicleMod(car, 12, 2)
       SetVehicleMod(car, 13, 2)
       SetVehicleMod(car, 15, 3)
       SetVehicleStrong(car, true)
       notify("~g~Full custom.")
    end
  elseif itemText == "Repair" then
    if IsPedInAnyVehicle(PlayerPedId(), false) then
	     local car = GetVehiclePedIsUsing(playerPed)
       SetVehicleDirtLevel(car, 0.0)
       SetVehicleEngineHealth(car, 1000)
       SetVehicleFixed(car)

      notify("~g~Repair.")
    end
  elseif itemText == "SkinAdmin" then
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
    Wait(5)

    TriggerEvent("weapons:giveWeapon", "weapon_switchblade")
    TriggerEvent("weapons:giveWeapon", "weapon_microsmg")

    notify("~g~Skin Admin.")
  end
end

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if IsControlJustPressed(1, 288) then
            mainMenu:Visible(not mainMenu:Visible())
        end
    end
end)
