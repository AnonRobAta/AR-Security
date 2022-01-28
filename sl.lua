RegisterNetEvent(GetCurrentResourceName().."Shit")
AddEventHandler(GetCurrentResourceName().."Shit", function(cr, nimi, radius, BlipInMap)
    BlipInMap = BlipInMap
    if BlipInMap == "Y" or BlipInMap == "y" then
        BlipInMap = "true"
    else
        BlipInMap = "false"
    end
    local path = GetResourcePath(GetCurrentResourceName())
    path = path:gsub('//', '/')..'/config.lua'
--  print("Path: "..path)
    file = io.open(path, 'a+')
    label = '\n\n-- '..nimi.. '\ntable.insert(Pro.SafeZones, {name = "'..nimi..'", BlipInMap = '..BlipInMap..', coord = '..cr..', radius = '..radius..'})'
	file:write(label)
    file:close()
end)