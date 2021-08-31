_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Vêtements", "~b~Vêtements")
_menuPool:Add(mainMenu)

function hairItem(hair)
  for i = 1, 22, 1 do
      hair:AddItem(NativeUI.CreateItem(i, ""))
  end
end

function torso2Item(torsos)
  for i = 1, 381, 1 do
      torsos:AddItem(NativeUI.CreateItem(i, ""))
  end
end

function faceItem(temp0)
  for i = 1, 45, 1 do
      temp0:AddItem(NativeUI.CreateItem(i, ""))
  end
end

function maskItem(temp1)
  for i = 1, 381, 1 do
      temp1:AddItem(NativeUI.CreateItem(i, ""))
  end
end

function torso1Item(temp3)
  for i = 1, 381, 1 do
      temp3:AddItem(NativeUI.CreateItem(i, ""))
  end
end
function legItem(temp4)
  for i = 1, 381, 1 do
      temp4:AddItem(NativeUI.CreateItem(i, ""))
  end
end
function parachuteItem(temp5)
  for i = 1, 381, 1 do
      temp5:AddItem(NativeUI.CreateItem(i, ""))
  end
end
function shoesItem(temp6)
  for i = 1, 381, 1 do
      temp6:AddItem(NativeUI.CreateItem(i, ""))
  end
end
function accessoryItem(temp7)
  for i = 1, 381, 1 do
      temp7:AddItem(NativeUI.CreateItem(i, ""))
  end
end
function undershirtItem(temp8)
  for i = 1, 381, 1 do
      temp8:AddItem(NativeUI.CreateItem(i, ""))
  end
end
function kevlarItem(temp9)
  for i = 1, 381, 1 do
      temp9:AddItem(NativeUI.CreateItem(i, ""))
  end
end
function badgeItem(temp10)
  for i = 1, 381, 1 do
      temp10:AddItem(NativeUI.CreateItem(i, ""))
  end
end

local hair = _menuPool:AddSubMenu(mainMenu, "Cheveux")
local torsos = _menuPool:AddSubMenu(mainMenu, "Torse2")
local temp0 = _menuPool:AddSubMenu(mainMenu, "Face")
local temp1 = _menuPool:AddSubMenu(mainMenu, "Mask")
local temp3 = _menuPool:AddSubMenu(mainMenu, "Torse1")
local temp4 = _menuPool:AddSubMenu(mainMenu, "Leg")
local temp5 = _menuPool:AddSubMenu(mainMenu, "Parachute")
local temp6 = _menuPool:AddSubMenu(mainMenu, "Shoes")
local temp7 = _menuPool:AddSubMenu(mainMenu, "Accessory")
local temp8 = _menuPool:AddSubMenu(mainMenu, "Undershirt")
local temp9 = _menuPool:AddSubMenu(mainMenu, "Badge")
local temp10 = _menuPool:AddSubMenu(mainMenu, "Kevlar")
hairItem(hair)
faceItem(temp0)
maskItem(temp1)
torso1Item(temp3)
legItem(temp4)
parachuteItem(temp5)
shoesItem(temp6)
accessoryItem(temp7)
undershirtItem(temp8)
kevlarItem(temp9)
badgeItem(temp10)
torso2Item(torsos)


RegisterNetEvent('clothes:setMenuClothingShops')
AddEventHandler('clothes:setMenuClothingShops', function(result)
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      local playerCoord = GetEntityCoords(PlayerPedId(), false)
      -- local locVector = vector3(result[0].position.x, result[0].position.y, result[0].position.z)
      -- local locVector = vector3(-1279.302, -3374.471, 13.94016)
      if Vdist2(playerCoord, locVector) < result[0].scale*1.12 and GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
        DisplayHelpText("Appuyer sur E")
        _menuPool:ProcessMenus()
        if IsControlJustPressed(1, 38) then
          mainMenu:Visible(not mainMenu:Visible())
        end
      end
    end
  end)
end)

hair.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  SetPedComponentVariation(PlayerPedId(), 2, tonumber(itemText), 3, 2)
end
torsos.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  SetPedComponentVariation(PlayerPedId(), 11, tonumber(itemText), 0, 0)
end
temp0.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  SetPedComponentVariation(PlayerPedId(), 0, tonumber(itemText), 0, 0)
end
temp1.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  SetPedComponentVariation(PlayerPedId(), 1, tonumber(itemText), 3, 2)
end
temp3.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  SetPedComponentVariation(PlayerPedId(), 3, tonumber(itemText), 3, 2)
end
temp4.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  SetPedComponentVariation(PlayerPedId(), 4, tonumber(itemText), 3, 2)
end
temp5.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  SetPedComponentVariation(PlayerPedId(), 5, tonumber(itemText), 3, 2)
end
temp6.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  SetPedComponentVariation(PlayerPedId(), 6, tonumber(itemText), 3, 2)
end
temp7.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  SetPedComponentVariation(PlayerPedId(), 7, tonumber(itemText), 3, 2)
end
temp8.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  SetPedComponentVariation(PlayerPedId(), 8, tonumber(itemText), 3, 2)
end
temp9.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  SetPedComponentVariation(PlayerPedId(), 9, tonumber(itemText), 3, 2)
end
temp10.OnItemSelect = function(sender, item, index)
  local itemText = item.Text._Text
  SetPedComponentVariation(PlayerPedId(), 10, tonumber(itemText), 3, 2)
end

_menuPool:RefreshIndex()
_menuPool:MouseControlsEnabled (false)
_menuPool:MouseEdgeEnabled (false)
_menuPool:ControlDisablingEnabled(false)
