ESX = nil

local Paskaa = false
local AntiSpam = false
local Trigger = nil
local Ready = false

Citizen.CreateThread(function()
    while Trigger == nil do
        Trigger = exports.ARSecurity:GetSecurityTrigger(GetCurrentResourceName())
        Wait(1500)
        if Trigger == nil then
            Trigger = exports.ARSecurity:GetSecurityTrigger(GetCurrentResourceName())
        end
    end
    Ready = true
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterCommand("ps", function ()
    if Ready then
        Token = exports.ARSecurity:RegenerateNewPlayersDataTriggerC()
        while Token == nil do
            Wait(500)
        end
        TriggerServerEvent(Trigger.."esx_kaivaminen:AnnaReward", Token)
    end
end)

RegisterNetEvent("esx_kaivaminen:AloitaKaivaminen")
AddEventHandler("esx_kaivaminen:AloitaKaivaminen", function()
    if Ready then
        Token = exports.ARSecurity:RegenerateNewPlayersDataTriggerC()
        Paskaa = not Paskaa
        ESX.ShowNotification("Paina [E] aloittaaksesi!")
        while Paskaa do
            Citizen.Wait(0)
            if IsControlJustReleased(0, 38) and AntiSpam == false then
                TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
                local Mx = math.random(5000, 15000)
                local Ch = math.random(0, 1)
                AntiSpam = true
                exports['progressBars']:startUI(15000 * 2 + Mx, "Kaivetaan...")
                Citizen.Wait(15000 * 2 + Mx + 500)
                if IsPedUsingScenario(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT") then
                    if Ch == 0 then
                        ClearPedTasksImmediately(PlayerPedId())
                        local proppi = CreateObject(GetHashKey("bkr_prop_coke_metalbowl_02"), 0, 0, 0, true, true, true)
                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BUM_WASH", 0, false)
                        AttachEntityToEntity(proppi, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.129, 0.14, 0.13, 270.0, 180.0, 300.0, true, true, false, true, 1, true)
                        exports['progressBars']:startUI(15000 * 2, "Huuhdot paskat pois!")
                        Citizen.Wait(15000 * 2 + 200)
                        DeleteEntity(proppi)
                    end
	    			ClearPedTasksImmediately(PlayerPedId())
                    TriggerServerEvent(Trigger.."esx_kaivaminen:AnnaReward", Token)
                    AntiSpam = false
                    ESX.ShowNotification("Paina [E] jatkaaksesi kaivuuta!")
                else
                    ESX.ShowNotification("Äläpä yritä huijata! Joudut käyttämään tavarasi uudestaan.")
                    Paskaa = false
                    AntiSpam = false
                end
           end
        end
    else
        ESX.ShowNotification("Generoidaan avainta! Odota hetki ja yritä uudelleen!")
    end
end)