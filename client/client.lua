Config = Config or {}
WeaponRecoils = Config.WeaponRecoils or {}

local function getCurrentWeapon()
    local ped = PlayerPedId()
    local _, weaponHash = GetCurrentPedWeapon(ped, true)
    return weaponHash
end

local function applyRecoil()
    local weapon = getCurrentWeapon()
    local recoilValue = WeaponRecoils[weapon]

    if recoilValue then
        local ped = PlayerPedId()
        local x, y = 0.0, 0.0

        x = math.random() * recoilValue - recoilValue / 2
        y = math.random() * recoilValue - recoilValue / 2

        SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + x, 0.2)
        SetGameplayCamRelativeHeading(GetGameplayCamRelativeHeading() + y)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedShooting(PlayerPedId()) then
            applyRecoil()
        end
    end
end)
