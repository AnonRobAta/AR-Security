local AddSecurityMinutes = 15
local PathToThisfile  = "resources/[esx]/[ESX-File]/"..GetCurrentResourceName().."/Data" -- /DataSec.txt
Citizen.CreateThread(function()
    if ClearSecurityTrigger() then
        StartLoop()
    end
end)

function ClearSecurityTrigger()
    TriggerSec = {}
    Wait(1000)
    for resources = 0, GetNumResources() - 1 do
        local _resname = GetResourceByFindIndex(resources)
        local Trigger = RandomVariable()
        local Trigger2 = RandomVariable()
        local Value = 1
        local Value2 = 1
        local Value3 = 1
        local Ch = math.random(3, 5)

        for i=1, Ch do
            Value = Value + math.random(777777, 8888888)
            Value2 = Value2 + math.random(7777777, 7777777777)
            Value3 = Value3 + math.random(9999999, 9999999999)
        end
        table.insert(TriggerSec, {Resource = _resname, Trigger = Trigger..Value..Value3..Trigger2..Value2})
    end
    FlushTriggerSec(true)
    return true
end

function FlushTriggerSec(boo)
    if boo then
        io.open(PathToThisfile.."/DataSec.txt","w"):close()
    end
    for i = 1, 1500 do
        local Trigger = RandomVariable()
        local Trigger2 = RandomVariable()
        local Value = 1 + math.random(666, 666666)
        local Value2 = 1 + math.random(666, 666666)
        local Value3 = 1 + math.random(666, 666666)

        for i=1, 999 do
            Value = Value * Value - Value2
            Value2 = Value2 * Value2 + Value
            Value3 = Value3 * Value3 + Value2
        end

        local Shit = "YouAreShitIfUmodder"..Trigger..Value..Value3..Trigger2..Value2.."Yep"

        file = io.open(PathToThisfile.."/DataSec.txt", "a")
        if file then
            file:write(Shit.." \n")
        end
        file:close()
    end
end

function StartLoop()
    Citizen.Wait(AddSecurityMinutes * 60 * 1000)
    GenerateVariable()
end

function RandomVariable()
    local res = ""
    for i = 1, 23 do
        res = res .. string.char(math.random(97, 122))
    end
    return res
end

function GenerateVariable()
    local Trigger = RandomVariable()
    local Trigger2 = RandomVariable()
    local Value = 1
    local Value2 = 1
    local Value3 = 1
    local Ch = math.random(3, 5)

    for i=1, Ch do
        Value = Value + math.random(777777777777, 88888888888888888888)
        Value2 = Value2 + math.random(777777777777, 999999999999999999999)
        Value3 = Value3 + math.random(8888888888888888888, 99999999999999999999999999999999999999999999)
    end

    local Shit = "YouAreShit"..Trigger..Value..Value3..Trigger2..Value2.."Yep"

    file = io.open(PathToThisfile.."/DataSec.txt", "a")
    if file then
        file:write(Shit.." \n")
    end
    file:close()
    StartLoop()
end

function File_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

function Lines_from(file)
    if not File_exists(file) then return {} end
        local lines = {}
        for line in io.lines(file) do
          lines[#lines + 1] = line
        end
    return lines
 end

function RegenerateNewPlayersDataTrigger()
    local viivat = Lines_from(PathToThisfile.."/DataSec.txt")
    return viivat[ math.random( #viivat ) ]
end

function GetSecurityTrigger(file)
    for Line, Files in pairs(TriggerSec) do
        if Files.Resource == file then
            return Files.Trigger
        end
    end
    return nil
end

function CheckPlayerTrigger(Data)
    local DeeData = {}
    local viivat = Lines_from(PathToThisfile.."/DataSec.txt")
    for Line, Content in pairs(viivat) do
        if Content == Data then
            DeeData = {["PossibleModder"] = false}
            return DeeData
        end
    end
    DeeData = {["PossibleModder"] = true}
    return DeeData
end