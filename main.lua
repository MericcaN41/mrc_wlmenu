ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local yenileKomut = "wlyenile" -- Whitelist yenilemek için kullandığınız komudu buraya yazın ÖRN: wlrefresh veya wlyenile

local display = false

RegisterNUICallback("ekle", function(data)
    if data.text == "Bir sen akıllısın kanka" then
        ESX.ShowNotification("Bir sen akıllısın kanka")
        return
    end

    TriggerServerEvent("wlekle",data.text)
end)

RegisterNUICallback("kapat", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("yenile", function(data)
    ExecuteCommand(yenileKomut)
end)

RegisterCommand("wlmenu",function(source,args)
    ESX.TriggerServerCallback("allowed",function(allowed)
        if not allowed then
            ESX.ShowNotification("Bunu yapmaya yetkiniz yok!")
            return
        end
        SetDisplay(true)
    end)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display) 
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display) 
    end
end)
