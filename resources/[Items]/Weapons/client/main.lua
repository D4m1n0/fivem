RegisterNetEvent("weapons:giveWeapon")
AddEventHandler('weapons:giveWeapon', function(weapon_model)
    print("model", weapon_model)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weapon_model), 999, false, false)
end)
