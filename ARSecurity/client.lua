ESX = nil

local Afa = nil
local Afa2 = nil
local fSPlayer = false
local FSPlayer2 = false
local KeyTaken = false
local PR = "ARSecurity:"

local ActualKey = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

AddEventHandler("playerSpawned", function()
	if not fSPlayer and not FSPlayer2 then
		fSPlayer = true
        local V = RandomVariable()
        local V2 = RandomVariable()
        local V4 = RandomVariable()
        math.randomseed(21525326523632623, 36437548548679)
        local R = math.random(0, 9999999999999999999999999)
        local R2 = math.random(0, 9999999999999999999999)
        ActualKey = V..R2..V4..R..V2
        if not KeyTaken then
		    TriggerServerEvent(PR.."Give", ActualKey)
            KeyTaken = true
        end
	end
end)

Citizen.CreateThread(function()
    if not fSPlayer and not FSPlayer2 then
        FSPlayer2 = true
        local V = RandomVariable()
        local V2 = RandomVariable()
        local V4 = RandomVariable()
        math.randomseed(21525326523632623, 36437548548679)
        local R = math.random(0, 9999999999999999999999999)
        local R2 = math.random(0, 9999999999999999999999)
        ActualKey = V..R2..V4..R..V2
        ActualKey = V..R2..V4..R..V2
        if not KeyTaken then
            TriggerServerEvent(PR.."Give", ActualKey)
            KeyTaken = true
        end
    end
end)

function RandomVariable()
    local res = ""
    for i = 1, 23 do
        res = res .. string.char(math.random(97, 122))
    end
    return res
end

function GetSecurityTrigger(File)
    ESX.TriggerServerCallback(PR.."FileKey", function(Key)
        Afa = Key
    end, File, ActualKey)
    return Afa
end

function RegenerateNewPlayersDataTriggerC()
    ESX.TriggerServerCallback(PR.."FileData", function(Key)
        Afa2 = Key
    end, ActualKey)
    return Afa2
end