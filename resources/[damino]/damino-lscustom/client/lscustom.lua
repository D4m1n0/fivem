local keyCustom = {
    ["perf"] = "Performances",
    ["horn"] = "Pouet Pouet",
    ["look"] = "Apparence"
}
local custom = {
    ["perf"] = {
        ["engine"]= {["name"]= "Moteur", ["length"]= 0, ["mod"]=11},
        ["brakes"]= {["name"]= "Freins", ["length"]= 0, ["mod"]=12},
        ["gearbox"]= {["name"]= "Boite de vitesse", ["length"]= 0, ["mod"]=13},
        ["suspension"]= {["name"]= "Suspension", ["length"]= 0, ["mod"]=15},
        ["armour"]= {["name"]= "Armure", ["length"]= 0, ["mod"]=16},
        ["nitrous"]= {["name"]= "Nitro", ["length"]= 0, ["mod"]=17},
        ["turbo"]= {["name"]= "Turbo", ["length"]= 0, ["mod"]=18}
    },
    ["horn"] = {
        ["first"]= {["name"]= "First", ["length"]= 0, ["mod"]=14}
    },
    ["look"] = {
        ["spoiler"]= {["name"]= "Aileron", ["length"]= 0, ["mod"]=0},
        ["skirt"]= {["name"]= "Jupe", ["length"]= 0, ["mod"]=3},
        ["exhaust"]= {["name"]= "Echappement", ["length"]= 0, ["mod"]=4},
        -- ["chassis"]= {["name"]= "Chassis", ["length"]= 0, ["mod"]={5, 42, 43, 44, 45}},
        ["grill"]= {["name"]= "Grille", ["length"]= 0, ["mod"]=6},
        ["bonnet"]= {["name"]= "Capot", ["length"]= 0, ["mod"]=7},
        ["wing_l"]= {["name"]= "Aile gauche", ["length"]= 0, ["mod"]=8},
        ["wing_r"]= {["name"]= "Aile droite", ["length"]= 0, ["mod"]=9},
        ["roof"]= {["name"]= "Toit", ["length"]= 0, ["mod"]=10},
        ["subwoofer"]= {["name"]= "Haut-parleur", ["length"]= 0, ["mod"]=19},
        ["tyre_smoke"]= {["name"]= "Fumée pneus", ["length"]= 0, ["mod"]=20},
        ["hydraulics"]= {["name"]= "Hydrauliques", ["length"]= 0, ["mod"]=21},
        ["xenon_lights"]= {["name"]= "Xénon", ["length"]= 0, ["mod"]=22},
        ["wheels"]= {["name"]= "Roues", ["length"]= 0, ["mod"]=23},
        -- ["interior"]= {["name"]= "Intérieur", ["length"]= 0, ["mod"]={27, 28, 29, 30, 31}},
        ["chaise"]= {["name"]= "Chaise", ["length"]= 0, ["mod"]=32},
        ["steering"]= {["name"]= "Direction", ["length"]= 0, ["mod"]=33},
        -- "knob"= {"name"= "Pommeau", ["length"]= 0, ["mod"]=34},
        ["plaque"]= {["name"]= "Plaque", ["length"]= 0, ["mod"]=35},
        ["ice"]= {["name"]= "Glace", ["length"]= 0, ["mod"]=36},
        ["trunk"]= {["name"]= "Coffre", ["length"]= 0, ["mod"]=37},
        ["hydro"]= {["name"]= "Hydro", ["length"]= 0, ["mod"]=38},
        -- ["enginebay"]= {["name"]= "Compartiment moteur", ["length"]= 0, ["mod"]={39, 40, 41}},
        ["door_l"]= {["name"]= "Porte gauche", ["length"]= 0, ["mod"]=46},
        ["door_r"]= {["name"]= "Porte droite", ["length"]= 0, ["mod"]=47},
        ["lightbar"]= {["name"]= "Barre de lumière", ["length"]= 0, ["mod"]=49}
    }
}

function split(str, delimiter)
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

local lscustomMenu = MenuV:CreateMenu("LS Custom", 'LS Custom', 'topleft', 0, 0, 0, 'size-125', 'lscustom', 'menuv', '')
local perfMenu = MenuV:CreateMenu("Performance", 'Performance Menu', 'topleft', 0, 0, 0)
local perfButton = lscustomMenu:AddButton({ icon = '', label = "Performance Menu", value = perfMenu, description = 'Perf menu'})
local hornMenu = MenuV:CreateMenu("Pouet Pouet", 'Pouet Pouet Menu', 'topleft', 0, 0, 0)
local hornButton = lscustomMenu:AddButton({ icon = '', label = "Pouet Pouet Menu", value = hornMenu, description = 'Pouet Pouet menu'})
local lookMenu = MenuV:CreateMenu("Apparence", 'Apparence Menu', 'topleft', 0, 0, 0)
local lookButton = lscustomMenu:AddButton({ icon = '', label = "Apparence Menu", value = lookMenu, description = 'Apparence menu'})

perfMenu:On('open', function(m)
    m:ClearItems()
    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
    local engineSlider = perfMenu:AddSlider({ icon="", label="Moteur", value="demo", values={
        ["value"] = -1,
        ["label"] = "Standard"
    }})
end)

lookMenu:On('open', function(m)
    m:ClearItems()
    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
    local lookValues = {}
    if GetNumVehicleMods(vehicle, 0) > 0 then
        local mod = 0
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local spoilerSlider = lookMenu:AddSlider({ icon="", label="Aileron", value="demo", values=lookValues[mod]})
        spoilerSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 1) > 0 then
        local mod = 1
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local frontSlider = lookMenu:AddSlider({ icon="", label="Avant", value="demo", values=lookValues[mod]})
        frontSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 2) > 0 then
        local mod = 2
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local rearSlider = lookMenu:AddSlider({ icon="", label="Arrière", value="demo", values=lookValues[mod]})
        rearSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 3) > 0 then
        local mod = 3
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local skirtSlider = lookMenu:AddSlider({ icon="", label="Jupe", value="demo", values=lookValues[mod]})
        skirtSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 4) > 0 then
        local mod = 4
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local exhaustSlider = lookMenu:AddSlider({ icon="", label="Echappement", value="demo", values=lookValues[mod]})
        exhaustSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 5) > 0 then
        local mod = 5
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local frameSlider = lookMenu:AddSlider({ icon="", label="Cadre", value="demo", values=lookValues[mod]})
        frameSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 6) > 0 then
        local mod = 6
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local grilleSlider = lookMenu:AddSlider({ icon="", label="Grille", value="demo", values=lookValues[mod]})
        grilleSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 7) > 0 then
        local mod = 7
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local hoodSlider = lookMenu:AddSlider({ icon="", label="Capot", value="demo", values=lookValues[mod]})
        hoodSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 8) > 0 then
        local mod = 8
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local fenderLeftSlider = lookMenu:AddSlider({ icon="", label="Aile gauche", value="demo", values=lookValues[mod]})
        fenderLeftSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 9) > 0 then
        local mod = 9
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local fenderRightSlider = lookMenu:AddSlider({ icon="", label="Aile droite", value="demo", values=lookValues[mod]})
        fenderRightSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 10) > 0 then
        local mod = 10
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local roofSlider = lookMenu:AddSlider({ icon="", label="Toit", value="demo", values=lookValues[mod]})
        roofSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 19) > 0 then
        local mod = 19
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local subwooferSlider = lookMenu:AddSlider({ icon="", label="Haut-parleur", value="demo", values=lookValues[mod]})
        subwooferSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    -- if GetNumVehicleMods(vehicle, 20) > 0 then
    --     local mod = 20
    --     lookValues[mod] = {}
    --     for i=0, GetNumVehicleMods(vehicle, mod) do
    --         lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
    --     end
    --     local tyreSmokeSlider = lookMenu:AddSlider({ icon="", label="Fumée pneu", value="demo", values=lookValues[mod]})
    --     tyreSmokeSlider:On('change', function(item, value)
    --         SetVehicleModKit(vehicle, 0)
    --         ToggleVehicleMod(car, 20, true)
    --         SetVehicleMod(vehicle, mod, value)
    --     end)
    -- end
    if GetNumVehicleMods(vehicle, 38) > 0 then
        local mod = 38
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local hydrolicsSlider = lookMenu:AddSlider({ icon="", label="Hydrauliques", value="demo", values=lookValues[mod]})
        hydrolicsSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    -- if GetNumVehicleMods(vehicle, 22) > 0 then
    --     local mod = 22
    --     lookValues[mod] = {}
    --     for i=0, GetNumVehicleMods(vehicle, mod) do
    --         lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
    --     end
    --     local xenonSlider = lookMenu:AddSlider({ icon="", label="Xénon", value="demo", values=lookValues[mod]})
    --     xenonSlider:On('change', function(item, value)
    --         SetVehicleModKit(vehicle, 0)
    --         SetVehicleMod(vehicle, mod, value)
    --     end)
    -- end
    if GetNumVehicleMods(vehicle, 23) > 0 then
        local mod = 23
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local wheelsSlider = lookMenu:AddSlider({ icon="", label="Roues", value="demo", values=lookValues[mod]})
        wheelsSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 32) > 0 then
        local mod = 32
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local seatsSlider = lookMenu:AddSlider({ icon="", label="Sièges", value="demo", values=lookValues[mod]})
        seatsSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 35) > 0 then
        local mod = 35
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local plaqueSlider = lookMenu:AddSlider({ icon="", label="Plaque", value="demo", values=lookValues[mod]})
        plaqueSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 37) > 0 then
        local mod = 37
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local trunkSlider = lookMenu:AddSlider({ icon="", label="Coffre", value="demo", values=lookValues[mod]})
        trunkSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
    if GetNumVehicleMods(vehicle, 46) > 0 then
        local mod = 46
        lookValues[mod] = {}
        for i=0, GetNumVehicleMods(vehicle, mod) do
            lookValues[mod][i] = { ["value"]= i, ["label"]= tostring(i) }
        end
        local windowsSlider = lookMenu:AddSlider({ icon="", label="Fenêtres", value="demo", values=lookValues[mod]})
        windowsSlider:On('change', function(item, value)
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, mod, value)
        end)
    end
end)

RegisterCommand('setMod', function(source, args)
    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
    SetVehicleModKit(vehicle, 0)
    -- ToggleVehicleMod(vehicle, args[1], true)
    SetVehicleMod(vehicle, args[1], args[2], false)
    -- SetVehicleNeonLightEnabled(vehicle, 0, true)
    -- SetVehicleNeonLightEnabled(vehicle, 1, true)
    -- SetVehicleNeonLightEnabled(vehicle, 2, true)
    -- SetVehicleNeonLightEnabled(vehicle, 3, true)
    -- SetVehicleNeonLightsColour(vehicle, 1, 255, 1)
    local vehicleModel = GetEntityModel(vehicle)
    local vehicleName = GetDisplayNameFromVehicleModel(vehicleModel)
    print("Vous êtes dans un véhicule de type " .. vehicleName .. " arguments : "..args[1].." et "..args[2])
    print(GetVehicleMod(vehicle, args[1]))
    -- for i = 0, 49 do
    --     print(i, GetNumVehicleMods(vehicle, i))
    -- end
end)

RegisterCommand('createVeh', function (source, args)
    local model = GetHashKey(args[1])
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(50)
    end
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local car = CreateVehicle(model, x + 2, y + 2, z + 1, GetEntityHeading(GetPlayerPed(-1)), true, false)
    SetEntityAsNoLongerNeeded(car)
    SetModelAsNoLongerNeeded(model)
end)

RegisterNetEvent('damino:lscustom:createMenu')
AddEventHandler('damino:lscustom:createMenu', function(result)
    -- print("test")
    -- local lscustomMenu = MenuV:CreateMenu("LS Custom", 'LS Custom', 'topleft', 0, 0, 0, 'size-125', 'lscustom', 'menuv', '')
    -- local perfMenu = MenuV:CreateMenu("Performance", 'Performance Menu', 'topleft', 0, 0, 0)
    -- local hornMenu = MenuV:CreateMenu("Pouet Pouet", 'Horn Menu', 'topleft', 0, 0, 0)

    -- lscustom:On('open', function(m)
    --     for i, v in custom do
    --         print(v)
    --     end
    -- end)

    -- -- local perfButton = adminMenu:AddButton({ icon = '', label = 'Perf', value = perfMenu, description = 'Perf menu'})
    -- -- Before SetVehicleMod = SetVehicleModKit(car, 0)
    -- -- SetVehicleMod(vehicle, ModType, ModIndex)
    -- -- Button Colors 
    -- ---- Color1 = SetVehicleModColor_1
    -- ---- Color2 = SetVehicleModColor_2
    lscustomMenu:OpenWith('keyboard', 'e')
end)