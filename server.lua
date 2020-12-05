ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
Whitelist = {}
local webhookURL = "https://discord.com/api/webhooks/776361088870252555/NkaMNQSPk1BvJTMWeOkAQGnmnCGkDhLJWk83ifxuabngaWRYLg2B9iyexdGlTCoh_dkX"
local logaktif = false

ESX.RegisterServerCallback("allowed", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= "superadmin" then 
            cb(false)
        else
            cb(true)
        end
    else
        cb(false)
    end
end)

RegisterNetEvent("wlekle")
AddEventHandler("wlekle",function(hex)
    local _source = source
    local yes = false
    local res = MySQL.Sync.fetchAll("SELECT * FROM whitelist WHERE identifier = @identifier", {["@identifier"] = hex})
    if #json.encode(res) > 2 then
        yes = true
    else
        yes = false
    end
    if yes == false then
        MySQL.Async.execute("INSERT INTO whitelist (`identifier`) VALUES (@identifier)",{
            ["@identifier"] = hex
        },function(rows)
            TriggerClientEvent("esx:showNotification",_source,hex .. " whiteliste eklendi!")
            if logaktif == true then
                hook("**" .. hex .. "**" .. " whiteliste eklendi! \nEkleyen kişi: " .. GetPlayerName(_source) .. " **[**" .. _source .. "**]**")
            end
        end)
    else
        TriggerClientEvent("esx:showNotification",_source,hex .. " zaten whitelistli!")
    end
end)

function hook(mesaj)
    local embed = {
        {
            ["color"] = 3553599,
            ["title"] = "Whitelist eklendi!",
            ["description"] = mesaj,
            ["footer"] = {
                ["text"] = "Whitelist menu ile eklendi"
            }
        }
    }
    PerformHttpRequest(webhookURL, function(err,text,headers) end, "POST", json.encode({embeds=embed}), {["Content-Type"] = "application/json"})
end
