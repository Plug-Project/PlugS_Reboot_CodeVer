fx_version 'cerulean'
games { 'gta5' }

ui_page "dist/index.html"
files {
  "dist/**"
}

server_scripts {
  "@vrp/lib/utils.lua",
  "server/index.lua"
}

client_scripts {
  "client/index.lua"
}