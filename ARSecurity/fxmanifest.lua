game 'gta5'

fx_version 'cerulean'

client_scripts {
   'client.lua'
}

exports {
   'GetSecurityTrigger',
   'RegenerateNewPlayersDataTriggerC'
}

server_scripts {
   'server.lua'
}

server_exports {
   "CheckPlayerTrigger",
   "GetSecurityTrigger",
   "RegenerateNewPlayersDataTrigger",
}