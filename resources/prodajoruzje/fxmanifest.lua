fx_version 'bodacious'
game 'gta5'


description 'ESX Prodaja oruzja'

version '1.0.0'

server_scripts {
  '@es_extended/locale.lua',
  '@oxmysql/lib/MySQL.lua',
  'config.lua',
  'server/main.lua'
}

client_scripts {
  '@PolyZone/client.lua',
  '@es_extended/locale.lua',
  'config.lua',
  'client/main.lua'
}

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/app.js',
	'html/main.css',
	'html/ralesrecka.png',
	'html/carbine/*.png',
	'html/kalas/*.png',
	'html/special/*.png',
	'html/smg/*.png'
}