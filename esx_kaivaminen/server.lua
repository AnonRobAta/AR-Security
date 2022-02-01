local Trigger = nil
local Token = exports.ARSecurity:RegenerateNewPlayersDataTrigger()

Citizen.CreateThread(function()
	while Trigger == nil do
        Trigger = exports.ARSecurity:GetSecurityTrigger(GetCurrentResourceName())
        Wait(1500)
        if Trigger == nil then
			Trigger = exports.ARSecurity:GetSecurityTrigger(GetCurrentResourceName())
        end
    end
end)

ESX = nil TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem("maalapio", function(source)
    Token = exports.ARSecurity:RegenerateNewPlayersDataTrigger()
    TriggerClientEvent("esx_kaivaminen:AloitaKaivaminen", source, Token, Trigger)
end)

Citizen.CreateThread(function()
	while Trigger == nil do
		Citizen.Wait(1000)
	end
	RegisterNetEvent(Trigger.."esx_kaivaminen:AnnaReward")
	AddEventHandler(Trigger.."esx_kaivaminen:AnnaReward", function(ProvidedToken)
	    local check = exports.ARSecurity:CheckPlayerTrigger(ProvidedToken)
		local src = source
	    if check["PossibleModder"] == false then
	        local xPlayer = ESX.GetPlayerFromId(src)
	        local lootti = math.random(0, 2000)

			if lootti >= 0 and lootti <= 1 then -- 1, 2k
				Notif(src, "Sinä löysit: ~r~AK-47")
				xPlayer.addWeapon('WEAPON_ASSAULTRIFLE', 5)

			elseif lootti >= 2 and lootti <= 5 then  -- 3, 2k
				Notif(src, "Sinä löysit: ~r~ Beretta")
				xPlayer.addWeapon('WEAPON_PISTOL', 5)

			elseif lootti >= 6 and lootti <= 11 then  -- 5, 2k
				Notif(src, "Sinä löysit: ~r~ Vanhapistooli")
				xPlayer.addWeapon('WEAPON_VINTAGEPISTOL', 5)

			elseif lootti >= 12 and lootti <= 22 then -- 10, 2k
				Notif(src, "Sinä löysit: ~r~ Kultahippu")
				xPlayer.addInventoryItem('kultahippu', 1)

			elseif lootti >= 23 and lootti <= 73 then -- 50, 2k
				Notif(src, "Sinä löysit: ~r~ rubiini")
				xPlayer.addInventoryItem('Rubiini', 1)

			elseif lootti >= 74 and lootti <= 174 then -- 100, 2k
				Notif(src, "Sinä löysit: ~r~ Topaasi")
				xPlayer.addInventoryItem('topaasi', 1)

			elseif lootti >= 977 and lootti <= 1200 then
				Notif(src, "Sinä löysit: ~r~Opaali")
				xPlayer.addInventoryItem('opaali', 1)

			else
				Notif(src, "Sinä löysit: ~r~ Et mitään.")
			end
	    else
	        print("Pelaaja cheattaa: "..source)
	    end
	end)
end)

function Notif(src, msg)
	TriggerClientEvent('esx:showNotification', src, msg)
end