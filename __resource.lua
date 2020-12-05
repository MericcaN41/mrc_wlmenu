client_script  {
    "main.lua"
}

server_script { 
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

ui_page "html/index.html"
files {
    "html/index.html",
    "html/style.css",
    "html/main.js"
}