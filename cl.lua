ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local NaytaPaskaa = false

Citizen.CreateThread(function()
    sleep = 0
    Blips()
    while true do
        local ped = PlayerPedId()
        local ecrd = GetEntityCoords(ped)
        Citizen.Wait(sleep)
        sleeps = true
        for k, v in pairs(Pro.SafeZones) do
            ShitDistance = Vdist(ecrd.x, ecrd.y, ecrd.z, v.coord.x, v.coord.y, v.coord.z)
            if ShitDistance <= v.radius + 60.0 then
               DrawMarker(1, v.coord.x, v.coord.y, v.coord.z, 0, 0, 0, 0, 0, 0, v.radius + v.radius , v.radius + v.radius  , 2.0-1.0001, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
               sleep = 0
               sleeps = false
            end
        end
        if sleeps then
            sleep = 500
        end
    end
end)

Citizen.CreateThread(function()
    while true do
      local ped = PlayerPedId()
      local ecrd = GetEntityCoords(ped)
      Citizen.Wait(0)
        for k,v in pairs(Pro.SafeZones) do
            ShitDistance = Vdist(ecrd.x, ecrd.y, ecrd.z, v.coord.x, v.coord.y, v.coord.z)
            if ShitDistance <= v.radius * 2 then
                if ShitDistance <= v.radius + 3.0 then
                    NaytaPaskaa = true
                --    print("In area!")
                else
                    NaytaPaskaa = false
                --    print("Not in area!")
                end
            else
                Citizen.Wait(0)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        if NaytaPaskaa == true then
           DisableControlAction(0, 37)
           DisableControlAction(0, 80)
           DisableControlAction(1, 80)
           DisableControlAction(0, 140)
           DisableControlAction(1, 140)
           DisablePlayerFiring(PlayerPedId(), true)
           DisableFirstPersonCamThisFrame()
           SetWeaponDamageModifierThisFrame(GetSelectedPedWeapon(PlayerPedId()), -1000)
        end
    end
end)

function Blips()
    for k,v in pairs(Pro.SafeZones) do
        if v.BlipInMap then
            GreenBlip = AddBlipForCoord(v.coord)
            SetBlipSprite(GreenBlip, 303)
            SetBlipColour(GreenBlip, 49)
            SetBlipScale(GreenBlip, 0.5)
            SetBlipAsShortRange(GreenBlip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(v.name)
            EndTextCommandSetBlipName(GreenBlip)
            Area_blip = AddBlipForRadius(v.coord, v.radius)
            SetBlipSprite(Area_blip, 10)
        end
    end
end

function GetKeyboard(title, abs)
    AddTextEntry('FMMC_KEY_TIP8', title)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 56)
	ESX.ShowNotification("~b~"..abs)

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait( 0 )
	end

	local Value = GetOnscreenKeyboardResult()
    return Value
end

RegisterCommand("AddSafezone", function()
    local ped = PlayerPedId()
    local cr = GetEntityCoords(ped)
    local nimi = GetKeyboard("Nimi", "Määritä nimi")
    local radius = GetKeyboard("Radius", "Laita radius")
    local BlipInMap = GetKeyboard("Blip in map?", "Y/N")
    TriggerServerEvent(GetCurrentResourceName().."Shit", cr, nimi, radius, BlipInMap)
end, false)