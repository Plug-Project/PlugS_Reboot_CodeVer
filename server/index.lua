local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", GetCurrentResourceName())

on_reboot = false
time = 0
perm = ""


RegisterCommand("리붓", function(source, args, rawCommand)
    if (source ~= 0) then
        local user_id = vRP.getUserId({source})
        if (not vRP.hasPermission({user_id, "admin.reboot"})) then
            return
        end
    end
    if (args[1] == "취소") then
        TriggerClientEvent("StopRebootTimer", -1)
        time = 0 
        on_reboot = false
        return
    end
    
    if (args[1] ~= nil and tonumber(args[1]) ~= nil) then
        time = tonumber(args[1])*60
        
        on_reboot = true
        TriggerClientEvent("SetRebootTimer", -1, time)
    else
        if (source == 0) then
            print("^1[리붓] 올바른 명령어를 입력해주세요. 예시: 리붓 <분>^7")
        else
            vRPclient.notify(source, {"올바른 명령어를 입력해주세요. 예시: /리붓 <분>"})
        end
    end
end, false)


Citizen.CreateThread(function()
    while true do
        if (on_reboot) then
            if (time == 0) then
                for _, v in ipairs(GetPlayers()) do
                    vRP.kick({v, "안정적인 서버환경을 위해 서버 재부팅을 진행합니다. 디스코드 공지를 확인해주세요!"})
                end
            else
                time = time -1
                print("서버 리붓까지 남은 시간: "..time..". 리붓 취소를 원하신다면 콘솔 또는 명령어 '리붓 취소'를 입력 해주세요")
            end
        end
        Citizen.Wait(1000)
    end
end)



Citizen.CreateThread(function()
    Citizen.Wait(3000)
    print("\n^2리붓 스크립트를 성공적으로 로드하였습니다!")
    print("^2콘솔 사용 예시: 리붓 <분>")
    print("^2인게임 명령어 사용 예시: 리붓 <분> (관리자 전용)^7")
    
    while true do
        Citizen.Wait(20000)
        print("접속중인 온라인 플레이어: " .. #GetPlayers() .."명")
    end
end)