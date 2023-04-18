local adminMenu = MenuV:CreateMenu("Admin", 'Admin Menu', 'topleft', 0, 0, 0, 'size-125', 'admin', 'menuv', '')
local weaponMenu = MenuV:CreateMenu("weaponMenu", 'Weapon Menu', 'topleft', 0, 0, 0)
local carMenu = MenuV:CreateMenu("carMenu", 'Car Menu', 'topleft', 0, 0, 0)

local weaponButton = adminMenu:AddButton({ icon = '', label = 'Weapons', value = weaponMenu, description = 'Weapons menu'})
local carButton = adminMenu:AddButton({ icon = '', label = 'Cars', value = carMenu, description = 'Cars menu'})

local weaponsType = {"melee", "handgun", "submachine_gun", "shotgun", "assault_rifle", "heavy", "throwable", "misc", "sniper_rifle", "light_machine_gun"}
local carsType = {"compact", "coupe", "industrial", "muscle", "off-road", "sedan", "special", "sport", "sport_classic", "super", "suv", "van"}
local weaponsCategory = {}
local weapons = {}
local carsCategory = {}
local cars = {}

TriggerServerEvent('admin:getGuns')
TriggerServerEvent('admin:getCars')

RegisterNetEvent('admin:setGuns')
AddEventHandler('admin:setGuns', function(result)
    weapons = result["weapons"]
    weaponsCategory = result["categories"]
end)

RegisterNetEvent('admin:setCars')
AddEventHandler('admin:setCars', function(result)
    cars = result["cars"]
    carsCategory = result["categories"]
end)

local personnalButton = adminMenu:AddButton({ icon = "", label = "Personnal Vehicle", value="personnalVehicle", select= function()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local closestVehicle = GetClosestVehicle(x, y, z, 10.0, 0, 70)
    if closestVehicle then
        local mods = {
            ["engine"]=GetVehicleMod(closestVehicle, 11),
            ["brakes"]=GetVehicleMod(closestVehicle, 12),
            ["gearbox"]=GetVehicleMod(closestVehicle, 13),
            ["suspension"]=GetVehicleMod(closestVehicle, 15),
            ["armour"]=GetVehicleMod(closestVehicle, 16),
            ["nitrous"]=GetVehicleMod(closestVehicle, 17),
            ["turbo"]=GetVehicleMod(closestVehicle, 18),
            ["tyreSmoke"]=GetVehicleMod(closestVehicle, 20),
            ["color1"]=GetVehicleModColor_1(closestVehicle),
            ["color2"]=GetVehicleModColor_2(closestVehicle),
            ["neonLightColor"]=GetVehicleNeonLightsColour(closestVehicle)
        }
        local plate = GetVehicleNumberPlateText(closestVehicle)
        local name = GetDisplayNameFromVehicleModel(GetEntityModel(closestVehicle))
        TriggerServerEvent('admin:setPersonnalVehicle', { ["mods"]=mods, ["plate"]=plate, ["name"]=name })
    end
end})

local repairVehicleButton = adminMenu:AddButton({ icon="", label="Repair Vehicle", value="repairVehicle", select=function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local car = GetVehiclePedIsUsing(PlayerPedId())
        SetVehicleDirtLevel(car, 0.0)
        SetVehicleEngineHealth(car, 1000)
        SetVehicleFixed(car)

        notify("~g~Repair.")
    end
end})

local deleteCarButton = adminMenu:AddButton({ icon = "", label = "Delete Vehicle", value="deleteVehicle", select= function()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local closestVehicle = GetClosestVehicle(x, y, z, 10.0, 0, 70)
    if closestVehicle then
        DeleteEntity(closestVehicle)
        Wait(500)
    end
end})

weaponMenu:On('open', function(m)
    m:ClearItems()
    for i, v in ipairs(weaponsType) do
        slider = weaponMenu:AddSlider({ icon = '', label = weaponsCategory[v], value = 'demo', values = weapons[v] })
        slider:On('select', function(item, value)
            GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(value), 999, false, false)
        end)
    end
end)

carMenu:On('open', function(m)
    m:ClearItems()
    for i, v in ipairs(carsType) do
        slider = carMenu:AddSlider({ icon = '', label = carsCategory[v], value = "demo", values = cars[v]})
        slider:On('select', function(item, value)
            local model = GetHashKey(value)
            RequestModel(model)
            while not HasModelLoaded(model) do
                RequestModel(model)
                Citizen.Wait(50)
            end

            local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
            local closestVehicle = GetClosestVehicle(x, y, z, 10.0, 0, 70)
            if closestVehicle then
                DeleteEntity(closestVehicle)
                Wait(500)
            end
            local car = CreateVehicle(model, x + 2, y + 2, z + 1, GetEntityHeading(GetPlayerPed(-1)), true, false)
            print(car)
            SetPedIntoVehicle(PlayerPedId(), car, -1)
            SetVehicleModKit(car, 0)
            SetVehicleMod(car, 0, 2)
            SetVehicleMod(car, 11, 2)
            SetVehicleMod(car, 16, 1)
            SetVehicleMod(car, 12, 2)
            SetVehicleMod(car, 13, 2)
            SetVehicleMod(car, 15, 3)
            SetVehicleMod(car, 16, 4)
            SetVehicleMod(car, 17, 1)
            SetVehicleMod(car, 18, 1)
            SetVehicleModColor_1(car, 3, 1, 0)
            SetVehicleModColor_2(car, 3, 1, 0)
            ToggleVehicleMod(car, 20, true)
            SetVehicleTyreSmokeColor(car, 255, 0, 0)
            SetVehicleNeonLightEnabled(car, 0, true)
            SetVehicleNeonLightEnabled(car, 1, true)
            SetVehicleNeonLightEnabled(car, 2, true)
            SetVehicleNeonLightEnabled(car, 3, true)
            SetVehicleNeonLightsColour(car, 255, 1, 1)
            SetVehicleStrong(car, true)

            SetEntityAsNoLongerNeeded(car)
            SetModelAsNoLongerNeeded(model)
        end)
    end
end)

adminMenu:OpenWith('keyboard', 'F1') -- Press F1 to open Menu

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end