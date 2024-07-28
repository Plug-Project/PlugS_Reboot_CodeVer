local on_reboot = false
local time = 0

RegisterNetEvent('SetRebootTimer')
AddEventHandler('SetRebootTimer', function(minute)
    SendNUIMessage({ type = 'toggle', status = true })

    on_reboot = true
    time = minute
end)

RegisterNetEvent('StopRebootTimer')
AddEventHandler('StopRebootTimer', function()
    SendNUIMessage({ type = 'toggle', status = false })
    on_reboot = false
    time = 0
end)

Citizen.CreateThread(function()
    while true do
        if (on_reboot) then
            if (time ~= 0) then
                time = time - 1
                SendNUIMessage({ type = 'timer', time = time })
            end
        end
        Citizen.Wait(1000)
    end
end)