# AR-Security
FiveM file

Tää filu tekee aina filun restartattua uudet suojatriggerit.

clientside exportit:
   GetSecurityTrigger
   RegenerateNewPlayersDataTriggerC

serverside exportit:

CheckPlayerTrigger
GetSecurityTrigger
RegenerateNewPlayersDataTrigger

Esimerkki: Erittäin huonot mutta sun pitää osaa lua koodia jos muuten ei toimi

local OikeaSecurityTrigger = GetSecurityTrigger(GetCurrentResourceName())
AddEventHandler(OikeaSecurityTrigger.."Test")



local DataTrigger = RegenerateNewPlayersDataTrigger()
TriggerServerEvent("Test", DataTrigger)


local Pelaaja = CheckPlayerTrigger(Pelaajanantamatriggertähän)
if Pelaaja["PossibleModder"] == false then
    -- Ei luultava modaaja jatka toimia
else
    -- Luultavasti modaaja kickkaa bännää logaa tee mitä haluat    
