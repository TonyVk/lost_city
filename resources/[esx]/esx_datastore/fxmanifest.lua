fx_version 'bodacious'
game 'gta5'


description 'ESX Data Store'

version '1.0.2'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/classes/datastore.lua',
	'server/main.lua'
}
